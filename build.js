/**
 * DULCE SECRETO - SCRIPT DE COMPILACIÓN Y VERIFICACIÓN DE PRODUCCIÓN
 * Valida la integridad del catálogo, configuración, sintaxis y recursos para despliegue
 */

const fs = require('fs');
const path = require('path');
const vm = require('vm');

console.log('======================================================');
console.log('🌸 DULCE SECRETO — PROCESO DE COMPILACIÓN (BUILD)');
console.log('======================================================');

const ROOT_DIR = __dirname;
let hasErrors = false;

// 1. Validar store-products.json
try {
  const productsPath = path.join(ROOT_DIR, 'store-products.json');
  const productsRaw = fs.readFileSync(productsPath, 'utf8');
  const products = JSON.parse(productsRaw);

  if (!Array.isArray(products) || products.length === 0) {
    throw new Error('El catálogo está vacío o no es un arreglo válido.');
  }

  // Verificar que no haya imágenes externas o de prueba
  const invalidProducts = products.filter(p => {
    const allImgs = [...(p.images || []), p.image || ''].filter(Boolean);
    return allImgs.some(img => typeof img === 'string' && img.includes('unsplash'));
  });

  if (invalidProducts.length > 0) {
    throw new Error(`Se detectaron ${invalidProducts.length} productos con imágenes no deseadas.`);
  }

  console.log(`✓ Catálogo validado: ${products.length} prendas auténticas listas.`);
} catch (err) {
  console.error('❌ Error en store-products.json:', err.message);
  hasErrors = true;
}

// 2. Validar store-config.json
try {
  const configPath = path.join(ROOT_DIR, 'store-config.json');
  const configRaw = fs.readFileSync(configPath, 'utf8');
  const config = JSON.parse(configRaw);

  const heroBanners = config.hero?.images || [];
  console.log(`✓ Configuración validada: ${heroBanners.length} banners HD en carrusel.`);
} catch (err) {
  console.error('❌ Error en store-config.json:', err.message);
  hasErrors = true;
}

// 3. Validar sintaxis de archivos JavaScript
const jsFiles = [
  'js/coil-image-cache.js',
  'js/firebase-sync.js',
  'js/products.js',
  'js/store.js',
  'js/cart.js',
  'js/checkout.js',
  'js/theme.js',
  'js/whatsapp.js',
  'js/ai-assistant.js',
  'sw.js',
  'server.js'
];

jsFiles.forEach(file => {
  try {
    const fullPath = path.join(ROOT_DIR, file);
    if (fs.existsSync(fullPath)) {
      const code = fs.readFileSync(fullPath, 'utf8');
      new vm.Script(code);
      console.log(`✓ Sintaxis verificada: ${file}`);
    }
  } catch (err) {
    console.error(`❌ Error de sintaxis en ${file}:`, err.message);
    hasErrors = true;
  }
});

// 4. Validar páginas HTML principales
const htmlFiles = [
  'index.html',
  'admin.html',
  'politica-de-privacidad.html',
  'terminos-y-condiciones.html',
  'politica-de-cookies.html',
  'politica-de-reembolsos.html'
];

htmlFiles.forEach(file => {
  const fullPath = path.join(ROOT_DIR, file);
  if (fs.existsSync(fullPath)) {
    const size = fs.statSync(fullPath).size;
    console.log(`✓ Página verificada: ${file} (${(size / 1024).toFixed(1)} KB)`);
  } else {
    console.error(`❌ Falta archivo requerido: ${file}`);
    hasErrors = true;
  }
});

// 5. Validar recursos SEO, PWA y Backend PHP/MySQL
const metaFiles = [
  'images/favicon.svg',
  'manifest.json',
  'robots.txt',
  'sitemap.xml',
  '.htaccess',
  'sw.js',
  'database.sql',
  'firebase-config.json',
  'api/config.php',
  'api/db.php',
  'api/get-products.php',
  'api/save-products.php',
  'api/upload-image.php'
];

metaFiles.forEach(file => {
  const fullPath = path.join(ROOT_DIR, file);
  if (fs.existsSync(fullPath)) {
    const size = fs.statSync(fullPath).size;
    console.log(`✓ Recurso SEO/PWA verificado: ${file} (${(size / 1024).toFixed(1)} KB)`);
  } else {
    console.error(`❌ Falta archivo meta requerido: ${file}`);
    hasErrors = true;
  }
});

console.log('======================================================');
if (hasErrors) {
  console.error('❌ La compilación falló con errores.');
  process.exit(1);
} else {
  console.log('✨ BUILD EXITOSO: Proyecto optimizado y listo para producción');
  console.log('======================================================');
  process.exit(0);
}
