/**
 * ============================================================================
 * DULCE SECRETO — SERVICE WORKER (COIL-INSPIRED DISK CACHE FOR WEB)
 * Estrategia de almacenamiento persistente entre sesiones para imágenes y catálogo
 * ============================================================================
 */

const CACHE_VERSION = 'v1';
const IMAGE_CACHE_NAME = `dulce-secreto-coil-images-${CACHE_VERSION}`;
const STATIC_CACHE_NAME = `dulce-secreto-static-${CACHE_VERSION}`;

// Recursos iniciales prioritarios para precachear
const PRECACHE_ASSETS = [
  '/',
  '/index.html',
  '/css/theme.css',
  '/js/coil-image-cache.js',
  '/js/products.js',
  '/js/store.js',
  '/js/cart.js',
  '/js/checkout.js',
  '/store-products.json',
  '/store-config.json',
  '/images/favicon.svg',
  '/images/banners/banner-01-dulce-secreto-seduccion.jpg',
  '/images/banners/banner-02-lenceria-rosas-satin.jpg',
  '/images/banners/banner-03-conjunto-negro-vintage.jpg'
];

// 1. INSTALACIÓN: Precarga de recursos clave en segundo plano
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(STATIC_CACHE_NAME)
      .then((cache) => {
        return cache.addAll(PRECACHE_ASSETS).catch((err) => {
          console.warn('[SW:Coil] Fallo precarga de algunos recursos iniciales:', err);
        });
      })
      .then(() => self.skipWaiting())
  );
});

// 2. ACTIVACIÓN: Limpieza de cachés antiguas y toma de control inmediato
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== IMAGE_CACHE_NAME && key !== STATIC_CACHE_NAME) {
            console.log('[SW:Coil] Eliminando caché obsoleta:', key);
            return caches.delete(key);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// 3. INTERCEPTOR FETCH: Estrategia Cache-First para Imágenes de Productos
self.addEventListener('fetch', (event) => {
  const request = event.request;
  const url = new URL(request.url);

  // Solo procesar peticiones GET
  if (request.method !== 'GET') return;

  // Detección de imágenes (productos, banners, iconos)
  const isImage = 
    request.destination === 'image' || 
    url.pathname.includes('/images/') || 
    /\.(jpg|jpeg|png|webp|svg|gif|avif)$/i.test(url.pathname);

  if (isImage) {
    // ESTRATEGIA CACHE-FIRST (Idéntica al DiskCache de Coil):
    // 1. Buscar en CacheStorage (Disco local del navegador)
    // 2. Si existe, responder en 0ms sin consumir red
    // 3. Si no existe, descargar por red, guardar en caché y retornar
    event.respondWith(
      caches.open(IMAGE_CACHE_NAME).then((cache) => {
        return cache.match(request).then((cachedResponse) => {
          if (cachedResponse) {
            return cachedResponse;
          }

          return fetch(request).then((networkResponse) => {
            // Guardar solo respuestas válidas
            if (networkResponse && networkResponse.status === 200) {
              cache.put(request, networkResponse.clone());
            }
            return networkResponse;
          }).catch((fetchErr) => {
            console.warn('[SW:Coil] Error de red descargando imagen:', request.url, fetchErr);
            // Si falla la red, intentar devolver cualquier versión en caché previa
            return cachedResponse || new Response(
              '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="400" viewBox="0 0 300 400"><rect width="100%" height="100%" fill="#1a1a1a"/><text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#9e1b32" font-family="sans-serif" font-size="14">Dulce Secreto</text></svg>',
              { headers: { 'Content-Type': 'image/svg+xml' } }
            );
          });
        });
      })
    );
    return;
  }

  // Para datos de productos o configuración: Stale-While-Revalidate
  const isDataJson = url.pathname.endsWith('.json') && !url.pathname.includes('/api/');
  if (isDataJson) {
    event.respondWith(
      caches.open(STATIC_CACHE_NAME).then((cache) => {
        return cache.match(request).then((cachedResponse) => {
          const fetchPromise = fetch(request).then((networkResponse) => {
            if (networkResponse && networkResponse.status === 200) {
              cache.put(request, networkResponse.clone());
            }
            return networkResponse;
          }).catch(() => cachedResponse);

          return cachedResponse || fetchPromise;
        });
      })
    );
  }
});
