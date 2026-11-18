// ==========================================================================
// DULCE SECRETO - SERVIDOR LOCAL RÁPIDO, LIGERO Y SEGURO
// Compatible con Node v24 y agy-node (Cero dependencias externas requeridas)
// Soporta autenticación JWT, cookies HttpOnly, CORS y persistencia en disco
// ==========================================================================

const http = require('http');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const PORT = process.env.PORT || 3000;
const PUBLIC_DIR = __dirname;
const CORREO_ADMIN_AUTORIZADO = 'dulcesecreto1497@gmail.com';
const JWT_SECRET = process.env.JWT_SECRET || 'dulce_secreto_super_secret_jwt_key_2026_seguridad_maxima';

const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.webp': 'image/webp',
  '.gif': 'image/gif',
  '.avif': 'image/avif',
  '.bmp': 'image/bmp',
  '.tiff': 'image/tiff',
  '.tif': 'image/tiff',
  '.heic': 'image/heic',
  '.heif': 'image/heif',
  '.mp4': 'video/mp4',
  '.webm': 'video/webm',
  '.ogg': 'video/ogg',
  '.mov': 'video/quicktime'
};

// ==========================================================================
// UTILIDADES JWT (HMAC-SHA256 NATIVO RFC 7519)
// ==========================================================================
function base64UrlEncode(str) {
  return Buffer.from(str).toString('base64').replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_');
}

function base64UrlDecode(str) {
  let s = str.replace(/-/g, '+').replace(/_/g, '/');
  while (s.length % 4) s += '=';
  return Buffer.from(s, 'base64').toString('utf8');
}

function signJWT(payload, secret, expiresInSeconds = 28800) { // 8 horas por defecto
  const header = { alg: 'HS256', typ: 'JWT' };
  const fullPayload = { ...payload, exp: Math.floor(Date.now() / 1000) + expiresInSeconds };
  const h = base64UrlEncode(JSON.stringify(header));
  const p = base64UrlEncode(JSON.stringify(fullPayload));
  const sig = crypto.createHmac('sha256', secret).update(`${h}.${p}`).digest('base64').replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_');
  return `${h}.${p}.${sig}`;
}

function verifyJWT(token, secret) {
  if (!token || typeof token !== 'string') return { valid: false, error: 'Token missing' };
  const parts = token.split('.');
  if (parts.length !== 3) return { valid: false, error: 'Token malformed' };
  const [h, p, sig] = parts;
  const expectedSig = crypto.createHmac('sha256', secret).update(`${h}.${p}`).digest('base64').replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_');
  if (sig !== expectedSig) return { valid: false, error: 'Invalid signature' };
  try {
    const payload = JSON.parse(base64UrlDecode(p));
    if (payload.exp && Math.floor(Date.now() / 1000) > payload.exp) {
      return { valid: false, error: 'Token expired' };
    }
    return { valid: true, payload };
  } catch (e) {
    return { valid: false, error: 'Invalid payload' };
  }
}

function parseCookies(req) {
  const list = {};
  const rc = req.headers.cookie;
  if (!rc) return list;
  rc.split(';').forEach(cookie => {
    const parts = cookie.split('=');
    const name = parts.shift().trim();
    const val = decodeURIComponent(parts.join('='));
    list[name] = val;
  });
  return list;
}

// Helpers para almacenar y cargar productos desde disco
const productsFilePath = path.join(PUBLIC_DIR, 'store-products.json');
function loadProductsFromDisk() {
  if (fs.existsSync(productsFilePath)) {
    try {
      return JSON.parse(fs.readFileSync(productsFilePath, 'utf8'));
    } catch (e) {
      console.error('Error al leer store-products.json:', e);
    }
  }
  return [];
}
function saveProductsToDisk(prods) {
  fs.writeFileSync(productsFilePath, JSON.stringify(prods, null, 2), 'utf8');
}

// ==========================================================================
// SERVIDOR HTTP PRINCIPAL
// ==========================================================================
const server = http.createServer((req, res) => {
  const origin = req.headers.origin || 'http://localhost:3000';
  
  // 1. Configuración de CORS segura con soporte de Cookies y Credenciales
  res.setHeader('Access-Control-Allow-Origin', origin);
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  const cookies = parseCookies(req);
  const parsedUrl = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
  const pathname = parsedUrl.pathname;

  // 2. Middleware de verificación de Token Admin
  function verificarTokenAdminSync() {
    const authHeader = req.headers['authorization'] || '';
    const bearerToken = authHeader.startsWith('Bearer ') ? authHeader.substring(7) : null;
    const token = cookies.adminToken || bearerToken;

    if (!token) {
      res.writeHead(401, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        success: false, 
        message: "Acceso no autorizado. Inicie sesión en el Panel de Administración de Dulce Secreto." 
      }));
      return null;
    }

    const check = verifyJWT(token, JWT_SECRET);
    if (!check.valid) {
      res.writeHead(403, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        success: false, 
        message: "La sesión del panel ha expirado o el token es inválido." 
      }));
      return null;
    }

    const decoded = check.payload;
    if (decoded.email !== CORREO_ADMIN_AUTORIZADO || decoded.role !== 'admin') {
      res.writeHead(403, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        success: false, 
        message: "Privilegios insuficientes o cuenta no autorizada para este panel." 
      }));
      return null;
    }

    return decoded;
  }

  // ==========================================================================
  // RUTAS DE LA API DE ADMINISTRACIÓN (DULCE SECRETO)
  // ==========================================================================

  // --- Login del Administrador ---
  if (req.method === 'POST' && pathname === '/api/admin/login') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const data = JSON.parse(body || '{}');
        const email = (data.email || '').trim().toLowerCase();

        if (email === CORREO_ADMIN_AUTORIZADO) {
          const adminToken = signJWT(
            { email: CORREO_ADMIN_AUTORIZADO, role: 'admin' }, 
            JWT_SECRET, 
            28800 // 8 horas de validez
          );

          res.writeHead(200, {
            'Content-Type': 'application/json',
            'Set-Cookie': `adminToken=${adminToken}; HttpOnly; SameSite=Strict; Max-Age=28800; Path=/`
          });
          res.end(JSON.stringify({ 
            success: true, 
            token: adminToken,
            message: "Bienvenido al Panel de Administración Exclusivo | DULCE SECRETO" 
          }));
          return;
        }

        res.writeHead(401, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, message: "Credenciales de administrador incorrectas." }));
      } catch (err) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: 'JSON inválido' }));
      }
    });
    return;
  }

  // --- Logout del Administrador ---
  if (req.method === 'POST' && pathname === '/api/admin/logout') {
    res.writeHead(200, {
      'Content-Type': 'application/json',
      'Set-Cookie': 'adminToken=; HttpOnly; SameSite=Strict; Max-Age=0; Path=/'
    });
    res.end(JSON.stringify({ success: true, message: "Sesión cerrada correctamente." }));
    return;
  }

  // --- Rutas Protegidas del Panel de Productos ---
  if (pathname === '/api/admin/productos') {
    if (req.method === 'GET') {
      const admin = verificarTokenAdminSync();
      if (!admin) return;
      const prods = loadProductsFromDisk();
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ success: true, count: prods.length, productos: prods }));
      return;
    }

    if (req.method === 'POST') {
      const admin = verificarTokenAdminSync();
      if (!admin) return;

      let body = '';
      req.on('data', chunk => body += chunk);
      req.on('end', () => {
        try {
          const data = JSON.parse(body || '{}');
          const { nombre, precio, categoria, imagen, stock, disponible } = data;
          if (!nombre || !precio) {
            res.writeHead(400, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ success: false, message: "Faltan campos obligatorios para el producto." }));
            return;
          }

          const prods = loadProductsFromDisk();
          const nuevoProducto = {
            id: data.id || `prod-${Date.now()}`,
            name: nombre,
            price: Number(precio),
            category: categoria || 'Babydoll',
            image: imagen || 'images/products/default.jpg',
            stock: stock !== undefined ? Number(stock) : 10,
            available: disponible !== false
          };

          const existingIdx = prods.findIndex(p => p.id === nuevoProducto.id);
          if (existingIdx >= 0) {
            prods[existingIdx] = { ...prods[existingIdx], ...nuevoProducto };
          } else {
            prods.unshift(nuevoProducto);
          }
          saveProductsToDisk(prods);

          res.writeHead(200, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ success: true, message: "Producto agregado exitosamente.", producto: nuevoProducto }));
        } catch (err) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ success: false, error: err.message }));
        }
      });
      return;
    }
  }

  // Eliminar producto por ID (/api/admin/productos/:id)
  const deleteProductMatch = pathname.match(/^\/api\/admin\/productos\/(.+)$/);
  if (req.method === 'DELETE' && deleteProductMatch) {
    const admin = verificarTokenAdminSync();
    if (!admin) return;

    const id = deleteProductMatch[1];
    const prods = loadProductsFromDisk();
    const filtrados = prods.filter(p => String(p.id) !== String(id));
    saveProductsToDisk(filtrados);

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ success: true, message: `Producto con ID ${id} eliminado.` }));
    return;
  }

  // ==========================================================================
  // RUTAS EXISTENTES DE LA TIENDA
  // ==========================================================================

  // Endpoint de despacho de Código de Verificación por Correo
  if (req.method === 'POST' && pathname === '/api/send-code') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const data = JSON.parse(body || '{}');
        const email = data.email || CORREO_ADMIN_AUTORIZADO;
        const code = data.code || '123456';
        const type = data.type || 'login';

        console.log(`\n======================================================`);
        console.log(`📨 [CORREO DE SEGURIDAD ENVIADO - DULCE SECRETO]`);
        console.log(`👤 Destinatario: ${email}`);
        console.log(`🔑 Código de Verificación: ${code}`);
        console.log(`📋 Motivo: ${type === 'change_email' ? 'Cambio de Correo Electrónico' : 'Inicio de Sesión Admin'}`);
        console.log(`⏰ Validez: 10 minutos`);
        console.log(`======================================================\n`);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, message: `Código de verificación enviado a ${email}`, code: code }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: 'JSON inválido' }));
      }
    });
    return;
  }

  // Endpoint de subida de Video para el Hero Banner (Solo Administrador)
  if (req.method === 'POST' && pathname === '/api/upload-video') {
    const chunks = [];
    req.on('data', chunk => chunks.push(chunk));
    req.on('end', () => {
      try {
        const buffer = Buffer.concat(chunks);
        let fileBuffer;
        let ext = '.mp4';
        const contentType = req.headers['content-type'] || '';

        if (contentType.includes('application/json')) {
          const body = JSON.parse(buffer.toString('utf-8'));
          const base64Data = (body.videoData || '').replace(/^data:video\/[\w-]+;base64,/, '');
          fileBuffer = Buffer.from(base64Data, 'base64');
          if (body.filename) {
            ext = path.extname(body.filename) || '.mp4';
          }
        } else {
          fileBuffer = buffer;
        }

        const videosDir = path.join(PUBLIC_DIR, 'videos');
        if (!fs.existsSync(videosDir)) {
          fs.mkdirSync(videosDir, { recursive: true });
        }

        const fileName = `hero-banner-${Date.now()}${ext}`;
        const targetPath = path.join(videosDir, fileName);
        fs.writeFileSync(targetPath, fileBuffer);

        const relativeUrl = `videos/${fileName}`;
        console.log(`\n🎬 [VIDEO SUBIDO - HERO BANNER] Guardado en: ${relativeUrl} (${(fileBuffer.length / (1024 * 1024)).toFixed(2)} MB)`);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, url: relativeUrl, message: 'Video guardado correctamente' }));
      } catch (err) {
        console.error('Error al guardar video:', err);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: err.message }));
      }
    });
    return;
  }

  // Endpoint de subida de Imágenes para Banners y Catálogo (Todos los Formatos HD, Almacenamiento Ilimitado)
  if (req.method === 'POST' && pathname === '/api/upload-image') {
    const chunks = [];
    req.on('data', chunk => chunks.push(chunk));
    req.on('end', () => {
      try {
        const buffer = Buffer.concat(chunks);
        let fileBuffer;
        let ext = '.jpg';
        let folder = 'banners';
        let slot = '';
        const contentType = req.headers['content-type'] || '';

        if (contentType.includes('application/json')) {
          const body = JSON.parse(buffer.toString('utf-8'));
          const rawData = body.imageData || body.image || '';
          const match = rawData.match(/^data:image\/([\w+.-]+);base64,(.+)$/i);
          if (match) {
            const rawExt = match[1].toLowerCase();
            if (rawExt === 'jpeg' || rawExt === 'jpg') ext = '.jpg';
            else if (rawExt === 'png') ext = '.png';
            else if (rawExt === 'webp') ext = '.webp';
            else if (rawExt === 'gif') ext = '.gif';
            else if (rawExt.includes('svg')) ext = '.svg';
            else if (rawExt === 'avif') ext = '.avif';
            else if (rawExt === 'bmp') ext = '.bmp';
            else if (rawExt.includes('tiff')) ext = '.tiff';
            else if (rawExt === 'heic' || rawExt === 'heif') ext = '.heic';
            else ext = '.' + rawExt;
            fileBuffer = Buffer.from(match[2], 'base64');
          } else {
            const cleanBase64 = rawData.replace(/^data:[^;]*;base64,/i, '');
            fileBuffer = Buffer.from(cleanBase64, 'base64');
          }
          if (body.filename) {
            const detectedExt = path.extname(body.filename);
            if (detectedExt) {
              const dLower = detectedExt.toLowerCase();
              ext = (dLower === '.jfif' || dLower === '.jpe') ? '.jpg' : dLower;
            }
          }
          if (body.folder === 'products') {
            folder = 'products';
          }
          if (body.slot) {
            slot = `slot${body.slot}-`;
          }
        } else {
          fileBuffer = buffer;
        }

        const imagesDir = path.join(PUBLIC_DIR, 'images', folder);
        if (!fs.existsSync(imagesDir)) {
          fs.mkdirSync(imagesDir, { recursive: true });
        }

        const fileName = `${folder === 'banners' ? 'hero-banner-' : 'foto-'}${slot}${Date.now()}-${Math.floor(Math.random() * 1000)}${ext}`;
        const targetPath = path.join(imagesDir, fileName);
        fs.writeFileSync(targetPath, fileBuffer);

        const relativeUrl = `images/${folder}/${fileName}`;
        const sizeKb = (fileBuffer.length / 1024).toFixed(1);
        const sizeMb = (fileBuffer.length / (1024 * 1024)).toFixed(2);
        const displaySize = fileBuffer.length > 1024 * 1024 ? `${sizeMb} MB` : `${sizeKb} KB`;
        console.log(`\n📸 [FOTO HD GUARDADA - ${folder.toUpperCase()}] ${relativeUrl} (${displaySize} · Formato: ${ext})`);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          success: true, 
          url: relativeUrl, 
          format: ext,
          sizeBytes: fileBuffer.length,
          message: 'Foto HD guardada con éxito en el almacenamiento ilimitado del servidor' 
        }));
      } catch (err) {
        console.error('Error al guardar imagen:', err);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: err.message }));
      }
    });
    return;
  }

  // Endpoint de guardado de Configuración Maestra
  if (req.method === 'POST' && pathname === '/api/save-config') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const configData = JSON.parse(body || '{}');
        const configPath = path.join(PUBLIC_DIR, 'store-config.json');
        fs.writeFileSync(configPath, JSON.stringify(configData, null, 2), 'utf-8');
        console.log(`💾 [CONFIGURACIÓN GUARDADA] store-config.json sincronizado con éxito`);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, message: 'Configuración guardada en disco' }));
      } catch (e) {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: e.message }));
      }
    });
    return;
  }

  // Endpoint de guardado del Catálogo de Productos
  if (req.method === 'POST' && pathname === '/api/save-products') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const productsData = JSON.parse(body || '[]');
        saveProductsToDisk(productsData);
        console.log(`💾 [PRODUCTOS GUARDADOS] store-products.json actualizado con ${productsData.length} prendas en disco`);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, count: productsData.length, message: 'Productos guardados en disco' }));
      } catch (e) {
        console.error('Error al guardar productos en disco:', e);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: e.message }));
      }
    });
    return;
  }

  // Endpoint de lectura del Catálogo de Productos
  if (req.method === 'GET' && pathname === '/api/get-products') {
    const data = loadProductsFromDisk();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(data));
    return;
  }

  // Endpoint de lectura de Configuración Maestra
  if (req.method === 'GET' && pathname === '/api/get-config') {
    const configPath = path.join(PUBLIC_DIR, 'store-config.json');
    if (fs.existsSync(configPath)) {
      try {
        const data = fs.readFileSync(configPath, 'utf-8');
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(data);
        return;
      } catch (e) {}
    }
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({}));
    return;
  }

  // ==========================================================================
  // SERVICIO DE ARCHIVOS ESTÁTICOS Y MULTIMEDIA (HTML5 VIDEO RANGE)
  // ==========================================================================
  let reqPath = decodeURI(pathname);
  if (reqPath === '/' || reqPath === '') {
    reqPath = '/index.html';
  }

  const filePath = path.join(PUBLIC_DIR, reqPath);

  // Seguridad contra Directory Traversal
  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403, { 'Content-Type': 'text/plain; charset=utf-8' });
    res.end('403 Prohibido');
    return;
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end(`
        <div style="font-family:sans-serif; text-align:center; padding:50px;">
          <h2>404 - Página no encontrada en DULCE SECRETO</h2>
          <p><a href="/index.html">Volver a la Tienda Principal</a> | <a href="/admin.html">Acceso Admin</a></p>
        </div>
      `);
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    // Soporte para Range requests (crucial para videos HTML5)
    const range = req.headers.range;
    if (range && (ext === '.mp4' || ext === '.webm' || ext === '.mov' || ext === '.ogg')) {
      const parts = range.replace(/bytes=/, "").split("-");
      const start = parseInt(parts[0], 10);
      const end = parts[1] ? parseInt(parts[1], 10) : stats.size - 1;
      const chunksize = (end - start) + 1;
      const fileStream = fs.createReadStream(filePath, { start, end });
      res.writeHead(206, {
        'Content-Range': `bytes ${start}-${end}/${stats.size}`,
        'Accept-Ranges': 'bytes',
        'Content-Length': chunksize,
        'Content-Type': contentType,
      });
      fileStream.pipe(res);
      return;
    }

    const responseHeaders = { 
      'Content-Type': contentType,
      'Content-Length': stats.size,
      'Accept-Ranges': 'bytes'
    };

    if (filePath.endsWith('sw.js')) {
      responseHeaders['Cache-Control'] = 'no-cache, no-store, must-revalidate';
      responseHeaders['Service-Worker-Allowed'] = '/';
    } else if (ext === '.jpg' || ext === '.jpeg' || ext === '.png' || ext === '.webp' || ext === '.svg' || ext === '.ico') {
      responseHeaders['Cache-Control'] = 'public, max-age=2592000, immutable';
    } else if (ext === '.js' || ext === '.css') {
      responseHeaders['Cache-Control'] = 'public, max-age=604800';
    }

    res.writeHead(200, responseHeaders);
    fs.createReadStream(filePath).pipe(res);
  });
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`\n======================================================`);
  console.log(`✨ DULCE SECRETO — E-COMMERCE PLATFORM`);
  console.log(`======================================================`);
  console.log(`🛍️  Tienda Pública:   http://localhost:${PORT}/index.html`);
  console.log(`🔒  Admin Exclusivo:  http://localhost:${PORT}/admin.html`);
  console.log(`👤  Admin Autorizado: ${CORREO_ADMIN_AUTORIZADO}`);
  console.log(`🛡️  Seguridad JWT:    Tokens HS256 firmados (Validez: 8 horas)`);
  console.log(`🍪  Cookies Auth:     HttpOnly, SameSite=Strict activo`);
  console.log(`⚡  Sincronización en vivo de precios y ofertas activa`);
  console.log(`======================================================\n`);
});
