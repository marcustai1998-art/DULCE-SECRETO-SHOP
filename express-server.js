require('dotenv').config();
const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');

const app = express();

// ==========================================
// 1. CONFIGURACIÓN DE CORS
// ==========================================
const allowedOrigins = [
  process.env.FRONTEND_URL || 'http://localhost:3000',
  'http://127.0.0.1:3000',
  'http://localhost:5000',
  'http://127.0.0.1:5000'
];

const corsOptions = {
  origin: function (origin, callback) {
    if (!origin) return callback(null, true);
    if (allowedOrigins.indexOf(origin) !== -1 || process.env.NODE_ENV !== 'production') {
      callback(null, true);
    } else {
      callback(new Error('Acceso bloqueado por políticas de seguridad de Dulce Secreto.'));
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

app.use(cors(corsOptions));
app.use(express.json({ limit: '100mb' }));
app.use(express.urlencoded({ limit: '100mb', extended: true }));
app.use(cookieParser());

// Servir frontend si se ejecuta conjuntamente
app.use(express.static(__dirname));

// ==========================================
// 2. MIDDLEWARE DE AUTENTICACIÓN ADMIN
// ==========================================
const CORREO_ADMIN_AUTORIZADO = 'dulcesecreto1497@gmail.com';
const JWT_SECRET = process.env.JWT_SECRET || 'dulce_secreto_super_secret_jwt_key_2026';

const verificarTokenAdmin = (req, res, next) => {
  const token = req.cookies?.adminToken || req.headers['authorization']?.split(' ')[1];

  if (!token) {
    return res.status(401).json({ 
      success: false, 
      message: "Acceso no autorizado. Inicie sesión en el Panel de Administración de Dulce Secreto." 
    });
  }

  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ 
        success: false, 
        message: "La sesión del panel ha expirado o el token es inválido." 
      });
    }

    // Validación estricta del correo y rol del administrador
    if (decoded.email !== CORREO_ADMIN_AUTORIZADO || decoded.role !== 'admin') {
      return res.status(403).json({ 
        success: false, 
        message: "Privilegios insuficientes o cuenta no autorizada para este panel." 
      });
    }

    req.adminUser = decoded;
    next();
  });
};

// ==========================================
// 3. RUTAS DE LA API DEL PANEL
// ==========================================

// --- Login del Administrador ---
app.post('/api/admin/login', (req, res) => {
  const { email, password } = req.body;

  // Validación contra el correo autorizado de Dulce Secreto
  if (email === CORREO_ADMIN_AUTORIZADO) {
    const adminToken = jwt.sign(
      { email: CORREO_ADMIN_AUTORIZADO, role: 'admin' }, 
      JWT_SECRET, 
      { expiresIn: '8h' } // Las sesiones del panel expiran en 8 horas por seguridad
    );

    res.cookie('adminToken', adminToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'strict',
      maxAge: 8 * 60 * 60 * 1000
    });

    return res.json({ 
      success: true, 
      token: adminToken,
      message: "Bienvenido al Panel de Administración Exclusivo | DULCE SECRETO" 
    });
  }

  res.status(401).json({ success: false, message: "Credenciales de administrador incorrectas." });
});

// --- Logout del Administrador ---
app.post('/api/admin/logout', (req, res) => {
  res.clearCookie('adminToken');
  res.json({ success: true, message: "Sesión cerrada correctamente." });
});

// Helper para leer/escribir store-products.json
const productsPath = path.join(__dirname, 'store-products.json');
function loadProducts() {
  if (fs.existsSync(productsPath)) {
    try { return JSON.parse(fs.readFileSync(productsPath, 'utf8')); } catch (e) {}
  }
  return [];
}
function saveProducts(prods) {
  fs.writeFileSync(productsPath, JSON.stringify(prods, null, 2), 'utf8');
}

// --- Rutas Protegidas del Panel ---
app.get('/api/admin/productos', verificarTokenAdmin, (req, res) => {
  const productos = loadProducts();
  res.json({ success: true, count: productos.length, productos });
});

app.post('/api/admin/productos', verificarTokenAdmin, (req, res) => {
  const { nombre, precio, categoria, imagen, stock, disponible } = req.body;
  if (!nombre || !precio) {
    return res.status(400).json({ success: false, message: "Faltan campos obligatorios para el producto." });
  }

  const productos = loadProducts();
  const nuevoProducto = {
    id: req.body.id || `prod-${Date.now()}`,
    name: nombre,
    price: Number(precio),
    category: categoria || 'Babydoll',
    image: imagen || 'images/products/default.jpg',
    stock: stock !== undefined ? Number(stock) : 10,
    available: disponible !== false
  };

  const existingIdx = productos.findIndex(p => p.id === nuevoProducto.id);
  if (existingIdx >= 0) {
    productos[existingIdx] = { ...productos[existingIdx], ...nuevoProducto };
  } else {
    productos.unshift(nuevoProducto);
  }
  saveProducts(productos);

  res.json({ success: true, message: "Producto agregado exitosamente.", producto: nuevoProducto });
});

app.delete('/api/admin/productos/:id', verificarTokenAdmin, (req, res) => {
  const { id } = req.params;
  const productos = loadProducts();
  const filtrados = productos.filter(p => String(p.id) !== String(id));
  saveProducts(filtrados);
  res.json({ success: true, message: `Producto con ID ${id} eliminado.` });
});

// ==========================================
// 4. MANEJO GLOBAL DE ERRORES (Anti-fuga)
// ==========================================
app.use((err, req, res, next) => {
  console.error(`[ERROR EN PANEL DULCE SECRETO] ${new Date().toISOString()}:`, err);

  const statusCode = err.statusCode || 500;
  const isProduction = process.env.NODE_ENV === 'production';

  res.status(statusCode).json({
    success: false,
    message: isProduction && statusCode === 500
      ? "Error interno en el servidor del panel administrativo."
      : err.message,
    ...(isProduction ? {} : { stack: err.stack })
  });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Panel de Administración de DULCE SECRETO activo en el puerto ${PORT}`);
});
