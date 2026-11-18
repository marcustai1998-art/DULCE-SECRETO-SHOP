# DULCE SECRETO — Tienda Oficial de Lencería Premium Colombiana

Plataforma de comercio electrónico diseñada para **DULCE SECRETO**, con estética de alta corsetería colombiana, colecciones exclusivas, pasarela flexible (Contra Entrega en Bogotá & Nequi Nacional) y un completo **Modo Administrador** en tiempo real.

---

## 🌟 Características Principales

### 1. Arquitectura y Estructura Dulce Secreto
La página principal (`index.html`) sigue la arquitectura moderna de boutique de lujo:
* **Barra de Anuncios Superior (`#shopify-section-announcement-bar` / `t4-section-announcement-bar`):** 
  * Mensajes de envío gratis nacional, discreción de empaque y pasarelas (*Nequi, Contra Entrega*).
  * Promoción y beneficios de temporada (*Colección 2026*).
  * Acceso directo al **Modo Administrador**.
* **Encabezado Inline de Lujo (`#shopify-section-header-inline` / `t4s-section-header`):**
  * Logotipo e isotipo oficial de **DULCE SECRETO** (*Lencería · Ropa Interior · Seducción*).
  * Buscador rápido tipo Pill.
  * Selector de moneda colombiana **🇨🇴 COP ($)**.
  * Selector de temas de color y alternador de Modo Claro / Oscuro.
  * Bolsa de compras con badge numérico en tiempo real.
  * Menú de navegación con enlaces a: *Inicio, Líneas Dulce Secreto, Bailarinas, Babydolls, Bodys, Catálogo 2026, Asistente de Tallas IA y Panel Admin*.
* **Contenido Principal (`#MainContent` / `content-for-layout`):**
  * **Hero Slideshow (`#shopify-section-template--...__1646028739ae283905` / `t4s-sec-slideshow`):** Banner de alta seducción *Vino Secreto 2026* con cinta vertical lateral *"CATÁLOGO 2026 - NUEVO"*, títulos en serif/script, botones de acción (*Comprar Ahora 👆* y *Encuentra tu talla*) e insignia de envío gratis.
  * **Líneas del Grupo DULCE SECRETO (`#shopify-section-template--...__c596f934...` / `t4s-featured-collections`):**
    1. *Dulce Secreto Lingerie:* Alta corsetería, encajes franceses y copas estructuradas.
    2. *Seducción & Fantasía:* Bodys eróticos, arneses de satín y ligueros.
    3. *Sueños Íntimos:* Babydolls satín seda, kimonos fluidos y batas de alcoba.
    4. *Bailarinas & Bienestar:* Calzado sensual de alcoba, fragancias afrodisíacas y accesorios.
  * **Categorías y Catálogo (`#shopify-section-template--...__3bebbe45...` / `t4s-featured-collections`):**
    * Círculos de selección rápida de categorías (Bailarinas, Babydoll, Bodys).
    * Banner Promocional (*Nuevo Catálogo 2026*).
    * Catálogo *"Para ti"* con píldoras de filtrado, selector de ordenamiento y cuadrícula dinámica de prendas.
  * **Asistente IA de Tallas (`#shopify-section-template--...__8915ebaf...`):** Calculadora anatómica y chatbot asesor de estilo.
  * **Beneficios de Envío y Pago Seguro (`#shopify-section-template--...__164620932069107a3a` / `t4s-shipping`):** 4 insignias de confianza: Envío Gratis Nacional, Pago Contra Entrega, Empaque 100% Discreto y Asesoría VIP 24/7.
* **Pie de Página (`#t4s-footer`):**
  * `#shopify-section-footer`: 4 columnas con bio de marca, líneas de atención, garantía de compra y portal administrativo.
  * `#shopify-section-bottom-bar`: Copyright y logos de pasarelas (*Nequi, Contra Entrega*).
* **Barra Móvil Inferior (`#shopify-section-toolbar_mobile` / `t4s-toolbar-mobile`):** Acceso táctil a Inicio, Catálogo, Tallas IA, Bolsa y Admin.
* **Botón Flotante VIP de WhatsApp (`#dulceSecretoWhatsappRoot` & `#dulceSecretoVipWhatsappRoot`):** Desplegable multi-agente con DULCE (Pedidos y Envíos) y PECADO (Atención General y Consultas).

---

### 2. Paletas de Color y Sistema de Temas Dinámico
Disponibles en el selector de la cabecera y configurables por el administrador:
* 🍷 **Vino Secreto (Edición 2026 - Por Defecto):** Primario `#9e1b32`, fondo oscuro `#140306`, texto script cursiva `#c23b53` y ribbon vertical.
* 🌸 **Rosa Dulce:** Tono oficial romántico y coqueto.
* 🖤 **Negro Secreto:** Lujo, corsetería nocturna y acentos dorados.
* ❤️ **Rojo Pasión:** Sensual, provocativo y audaz.
* 🥂 **Nude Pastel:** Satín champagne y elegancia discreta.
* 🌓 **Modo Oscuro / Modo Claro** con soporte instantáneo.

---

### 3. Modo Administrador Exclusivo (`admin.html`)
Blindado exclusivamente para **`dulcesecreto1497@gmail.com`**:
* **Gestión de Prendas e Inventario:**
  * Modificación directa de precios regulares y precios de oferta flash.
  * **Galería de Fotos HD:** Subida directa desde PC o móvil con compresión Canvas HD (máx 800px, JPEG 0.8) en 4 tomas estratégicas: Principal, Trasera/Espalda, Detalle de Encaje y Foto en Modelo.
* **Pestaña "⚙️ Configuración Tienda":**
  * Modificación de colores principales y secundarios.
  * Números de WhatsApp de DULCE y PECADO con actualización inmediata en toda la web.
  * **Hero Banner Slideshow (Carrusel con Rotación Automática):**
    * Subida directa desde PC o móvil de **hasta 4 banners en alta resolución (HD)** con compresión automática Canvas (máx 1600px, JPEG 0.85).
    * Control de **Rapidez del cambio de imágenes:** selector dinámico de intervalo (2s, 3s, 4s, 5s recomendado, 6s, 8s o 10s).
    * Controles interactivos en tienda: indicadores Dots, flechas anterior/siguiente y pausa automática en hover para lectura cómoda.
  * Tarjetas promocionales y umbrales de envío gratis.
  * Cuenta bancaria oficial de Nequi.
  * Sincronización en vivo sin recargar pestañas mediante `BroadcastChannel` y `localStorage`.

---

## 🚀 Cómo Ejecutar la Tienda

### En Servidor Local (Recomendado):
Haz doble clic en:
`iniciar-tienda.bat`

Abrirá automáticamente:
* **Tienda:** `http://localhost:3000/index.html`
* **Admin:** `http://localhost:3000/admin.html`

### Directamente en el Navegador:
Abre directamente los archivos:
* [index.html](file:///C:/Users/lis14/.gemini/antigravity/scratch/dulce-secreto/index.html)
* [admin.html](file:///C:/Users/lis14/.gemini/antigravity/scratch/dulce-secreto/admin.html)

---

## 📁 Estructura del Proyecto

```text
dulce-secreto/
├── index.html            # Tienda virtual oficial Dulce Secreto Boutique
├── admin.html            # Back-Office exclusivo para dulcesecreto1497@gmail.com
├── server.js             # Servidor HTTP local con soporte Node / agy-node
├── iniciar-tienda.bat    # Script de arranque en 1 clic
├── css/
│   └── theme.css         # Estilos y variables de los 5 temas, galería HD y banner
├── js/
│   ├── products.js       # Catálogo inicial y configuración predeterminada
│   ├── store.js          # Estado global, sincronización en vivo y persistencia
│   ├── theme.js          # Controlador dinámico de temas y modo oscuro
│   ├── ai-assistant.js   # Algoritmo de tallas y chatbot asesor
│   ├── cart.js           # Carrito deslizable lateral y cross-selling
│   ├── checkout.js       # Pasarela contra entrega, transferencias y WhatsApp
│   └── whatsapp.js       # Widget flotante VIP multi-agente
├── images/
│   ├── banners/          # Banners oficiales HD de alta resolución
│   └── products/         # Fotografías de catálogo y productos
└── README.md             # Documentación técnica completa
```
