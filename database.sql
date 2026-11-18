-- ======================================================================
-- DULCE SECRETO — BASE DE DATOS MYSQL OFICIAL
-- Ejecutar en phpMyAdmin de Hostinger o en tu servidor MySQL
-- ======================================================================

CREATE TABLE IF NOT EXISTS `productos` (
  `id` VARCHAR(50) NOT NULL PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `category` VARCHAR(100) NOT NULL,
  `regularPrice` INT NOT NULL,
  `salePrice` INT NOT NULL,
  `isFlashSale` TINYINT(1) DEFAULT 1,
  `rating` DECIMAL(3,1) DEFAULT 4.9,
  `reviewsCount` INT DEFAULT 120,
  `salesCount` INT DEFAULT 500,
  `tags` JSON NULL,
  `description` TEXT NULL,
  `composition` VARCHAR(255) NULL,
  `sizes` JSON NULL,
  `images` JSON NULL,
  `crossSellIds` JSON NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ======================================================================
-- CARGA INICIAL DE LAS 38 PRENDAS CON PRECIOS Y FOTOS OFICIALES
-- ======================================================================
INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-15', 'Corset Body Negro en Encaje con Escote en V y Corte Anatómico', 'Corse', 74000, 50000, 1, 4.8, 94, 590, '["NUEVO","CORSET","PREMIUM"]', 'Body corset confeccionado en encaje de tacto ultrasuave con escote en V continuo, copas reforzadas sin aro y diseño anatómico que moldea la figura con máxima comodidad.', '89% Poliamida, 11% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/corset-body-negro-escote-profundo.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-14', 'Corset Body Vino Tinto con Acordonado Lateral en Cintas', 'Corse', 74000, 50000, 1, 5, 130, 830, '["NUEVO","CORSET","TENDENCIA"]', 'Elegante body corset color borgoña en encaje elastizado, con lazos entrelazados en los laterales para ceñir la cintura a la medida deseada.', '91% Poliamida, 9% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-body-vino-tinto-acordonado.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-13', 'Corset Body Negro en Encaje Floral con Lazo Decorativo', 'Corse', 74000, 50000, 1, 4.7, 86, 540, '["NUEVO","CORSET","CLÁSICO"]', 'Silueta estilizada en encaje floral negro continuo, escote corazón decorado con lazo de raso y tirantes graduables que brindan ajuste perfecto.', '90% Poliamida, 10% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-body-negro-encaje-lazo.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-12', 'Corset Body Negro con Escote Pronunciado y Tiras Cruzadas', 'Corse', 74000, 50000, 1, 4.9, 108, 690, '["NUEVO","CORSET","MODERNO"]', 'Body corset en encaje negro con escote en V pronunciado, tiras decorativas cruzadas en el pecho y espalda abierta con tirantes regulables.', '88% Poliamida, 12% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-body-negro-tiras-cruzadas.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-11', 'Corset Negro en Tul Geométrico y Encaje con Ligueros', 'Corse', 74000, 50000, 1, 4.8, 95, 620, '["NUEVO","CORSET","MÁS VENDIDO"]', 'Corset estructurado en microtul y encaje negro, con cortes geométricos en la cintura que afinan el contorno corporal y ligueros desmontables.', '90% Poliamida, 10% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/corset-negro-tul-encaje-ligueros.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-10', 'Corset Rojo Pasión Strappy con Tiras Dobles y Encaje', 'Corse', 74000, 50000, 1, 4.9, 112, 710, '["NUEVO","CORSET","ESTILO ÚNICO"]', 'Corset en encaje rojo brillante con diseño de tiras elásticas dobles en el abdomen y contorno, copas con soporte estructurado y juego de ligueros.', '89% Poliamida, 11% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-rojo-tiras-liguero-encaje.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-09', 'Corset Azul Noche con Herrajes Metálicos de Corazón y Encaje', 'Corse', 74000, 50000, 1, 5, 135, 820, '["NUEVO","CORSET","TENDENCIA"]', 'Diseño exclusivo en encaje azul marino intenso con herrajes plateados en forma de corazón en el escote y cintura, varillas anatómicas y ligueros a juego.', '90% Poliamida, 10% Spandex con herrajes de aleación niquelada.', '["S","M","L","XL","XXL"]', '["images/products/corset-azul-marino-herrajes-corazon.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-08', 'Corset Blanco en Tul Ilusión y Encaje con Ligueros', 'Corse', 74000, 50000, 1, 4.8, 79, 510, '["NUEVO","CORSET","SUAVE"]', 'Confeccionado en tul semitransparente con bordados florales en blanco puro, varillas flexibles que estilizan el talle y cuatro tirantes liguero graduables.', '88% Poliamida, 12% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/corset-blanco-tul-encaje-ligueros.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-07', 'Corset Body Blanco en Encaje Floral con Detalles de Vuelos', 'Corse', 74000, 50000, 1, 4.9, 104, 680, '["NUEVO","CORSET","EXCLUSIVO"]', 'Body corset en fino encaje blanco con delicados vuelos en tirantes y escote, panel central en tul suave y ligueros inferiores ajustables.', '90% Poliamida, 10% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-blanco-body-vuelos-encaje.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-06', 'Corset Rojo Escarlata con Acordonado Frontal y Encaje', 'Corse', 74000, 50000, 1, 5, 160, 940, '["NUEVO","CORSET","FAVORITO"]', 'Corset en encaje rojo escarlata con ojales metálicos y cinta trenzada ajustable al frente que permite graduar el talle, incluye copas con varilla y ligueros.', '92% Poliamida, 8% Elastano con cinta de satén.', '["S","M","L","XL","XXL"]', '["images/products/corset-rojo-acordonado-frontal-encaje.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-05', 'Corset Azul Marino Cuello Halter en Encaje Floral y Ligueros', 'Corse', 74000, 50000, 1, 4.8, 88, 570, '["NUEVO","CORSET","ELEGANCIA"]', 'Diseño cuello halter en encaje azul marino de alta elasticidad, copas con soporte y tirantes de liguero ajustables para una figura definida.', '88% Poliamida, 12% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-azul-marino-halter-encaje.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-04', 'Corset Blanco en Encaje Nupcial con Ligueros y Tirantes Ajustables', 'Corse', 74000, 50000, 1, 4.9, 96, 640, '["NUEVO","CORSET","NUPCIAL"]', 'Exquisito corset en encaje nupcial blanco con copas prehormonadas, varillas de soporte que enmarcan la cintura y ligueros regulables con acabados finos.', '90% Poliéster, 10% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/corset-blanco-encaje-tirantes-cruzados.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-03', 'Corset Rosa Pastel en Encaje con Varillas y Ligueros a Juego', 'Corse', 74000, 50000, 1, 5, 125, 810, '["NUEVO","CORSET","ROMÁNTICO"]', 'Confeccionado en encaje traslúcido rosa pastel con varillas verticales que estilizan la silueta, escote corazón con delicado lazo frontal y ligueros regulables.', '85% Poliamida, 15% Elastano de alta durabilidad.', '["S","M","L","XL","XXL"]', '["images/products/corset-rosa-encaje-copas-varilla.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-02', 'Corset Rojo Vino en Encaje con Copas Estructuradas y Ligueros', 'Corse', 74000, 50000, 1, 4.9, 118, 730, '["NUEVO","CORSET","TENDENCIA"]', 'Diseño elegante en encaje floral color vino tinto, con copas con varilla para óptimo soporte, silueta anatómica y tirantes liguero regulables.', '90% Poliamida, 10% Spandex hipoalergénico.', '["S","M","L","XL","XXL"]', '["images/products/corset-rojo-vino-encaje-ligueros.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-corse-01', 'Corset Estructurado Negro en Encaje con Tirantes Liguero', 'Corse', 74000, 50000, 1, 5, 142, 890, '["NUEVO","CORSET","MÁS VENDIDO"]', 'Corset estructurado confeccionado en fino encaje floral negro, con copas con varilla para realce natural, ballenas moldeadoras y cuatro ligueros ajustables con broches metálicos.', '88% Poliamida, 12% Spandex elástico con forro de algodón suave.', '["S","M","L","XL","XXL"]', '["images/products/corset-negro-encaje-liguero.jpg"]', '["ds-babydoll-04","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-07', 'Bralette Blanco Longline en Encaje con Panty a Juego', 'Bralete', 65000, 45000, 1, 5, 130, 750, '["NUEVO","BRALETTES","MÁS VENDIDO"]', 'Top tipo bralette largo (longline) en encaje floral blanco con copas estructuradas, tirantes ajustables y panty tipo culotte a juego en encaje suave.', '90% Poliamida, 10% Spandex de tacto suave.', '["S","M","L","XL","XXL"]', '["images/products/bralette-blanco-longline-encaje.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-06', 'Conjunto Bralette Rosa Palo en Encaje con Doble Tirante', 'Bralete', 65000, 45000, 1, 4.9, 89, 470, '["NUEVO","BRALETTES","DELICADO"]', 'Conjunto en suave encaje tono rosa empolvado con copas triangulares, tirantes dobles regulables y detalles de lazos satinados.', '88% Poliamida, 12% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/bralette-rosa-doble-tirante.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-05', 'Conjunto Bralette Rojo Halter con Cadenas Decorativas', 'Bralete', 65000, 45000, 1, 4.9, 105, 590, '["NUEVO","BRALETTES","EDICIÓN ESPECIAL"]', 'Conjunto en encaje rojo con cuello halter ajustable, herraje central en forma de corazón y cadenas metálicas decorativas que conectan al panty.', '90% Poliamida, 10% Spandex con forro suave.', '["S","M","L","XL","XXL"]', '["images/products/bralette-rojo-halter-cadenas.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-04', 'Conjunto Bralette Rojo con Tiras Geométricas y Encaje', 'Bralete', 65000, 45000, 1, 4.8, 78, 410, '["NUEVO","BRALETTES","FAVORITO"]', 'Conjunto confeccionado en encaje rojo con copas triangulares forradas y diseño de tiras geométricas decorativas sobre el pecho y la cintura.', '92% Poliamida, 8% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/bralette-rojo-tiras-geometricas.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-03', 'Conjunto Bralette Negro Diseño Contemporáneo con Aros Metálicos', 'Bralete', 65000, 45000, 1, 5, 110, 680, '["NUEVO","BRALETTES","ESTILO ÚNICO"]', 'Diseño contemporáneo en tejido negro liso y elástico con detalles de aros metálicos brillantes, gargantilla a juego y tiras cruzadas decorativas.', '90% Poliéster, 10% Elastano con herrajes inoxidables.', '["S","M","L","XL","XXL"]', '["images/products/bralette-negro-aros-metalicos.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-02', 'Conjunto Bralette Rojo con Copas Estructuradas y Lazos', 'Bralete', 65000, 45000, 1, 4.9, 92, 520, '["NUEVO","BRALETTES","TENDENCIA"]', 'Conjunto en encaje rojo escarlata con copas con varilla para soporte suave, lazos decorativos en los tirantes y panty con amarres laterales ajustables.', '88% Poliamida, 12% Spandex elástico.', '["S","M","L","XL","XXL"]', '["images/products/bralette-rojo-copas-lazos.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bralette-01', 'Conjunto Bralette Lila en Encaje Floral Festoneado', 'Bralete', 65000, 45000, 1, 5, 84, 460, '["NUEVO","BRALETTES","MÁS VENDIDO"]', 'Conjunto de dos piezas en encaje floral tono lila con tirantes anchos suaves, escote en V y bordes festoneados elásticos.', '90% Poliamida, 10% Spandex hipoalergénico.', '["S","M","L","XL","XXL"]', '["images/products/bralette-lila-encaje-festoneado.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-06', 'Conjunto Estilo Bailarina en Encaje Negro y Falda Tutú', 'Bailarinas', 72000, 50000, 1, 4.9, 102, 570, '["NUEVO","BAILARINAS","DESTACADO"]', 'Conjunto en encaje floral negro con tirantes de vuelos en los hombros, copas estructuradas y falda corta de tul con liguero.', '92% Poliamida, 8% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-encaje-negro-tutu.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-05', 'Conjunto Estilo Bailarina Rojo con Lazos y Falda de Tul', 'Bailarinas', 72000, 50000, 1, 4.8, 88, 490, '["NUEVO","BAILARINAS","FAVORITO"]', 'Conjunto rojo compuesto por top de satín con lazos decorativos y falda corta en capas de tul tipo tutú con ligueros integrados.', '90% Poliéster, 10% Satín seda con tul elástico.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-tutu-rojo-lazos.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-04', 'Conjunto Estilo Bailarina en Cuerotex con Falda de Aberturas y Tirantes', 'Bailarinas', 72000, 50000, 1, 5, 114, 620, '["NUEVO","BAILARINAS","ESTILO ÚNICO"]', 'Conjunto en cuerotex negro con arnés superior al cuello, falda con aberturas estilizadas y ligueros ajustables.', '90% Cuerotex sintético, 10% Spandex.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-cuerotex-aberturas-arnes.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-03', 'Conjunto Estilo Bailarina en Encaje Azul Marino con Vuelo', 'Bailarinas', 72000, 50000, 1, 4.9, 130, 780, '["NUEVO","BAILARINAS","EXCLUSIVO"]', 'Prenda en encaje floral elástico tono azul noche, con copas con varilla, falda corta de encaje con vuelo y detalle de broches decorativos.', '92% Poliamida, 8% Elastano con forro de algodón suave.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-encaje-azul-marino.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-02', 'Conjunto Estilo Bailarina en Tul Negro con Vuelos Rojos', 'Bailarinas', 72000, 50000, 1, 4.9, 95, 540, '["NUEVO","BAILARINAS","TENDENCIA"]', 'Conjunto elaborado en tul suave negro con ribetes ondulados en contraste rojo, apliques decorativos de corazón y falda corta con doble volante.', '88% Poliamida, 12% Spandex elástico de alta suavidad.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-tul-negro-ribetes-rojos.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-bailarina-01', 'Conjunto Estilo Bailarina en Cuerotex con Falda Acampanada', 'Bailarinas', 72000, 50000, 1, 5, 108, 650, '["NUEVO","BAILARINAS","MÁS VENDIDO"]', 'Conjunto de dos piezas confeccionado en cuerotex sintético con top de copas estructuradas y falda corta acampanada con pretina de tiras.', '90% Poliéster con acabado cuerotex, 10% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/bailarina-cuerotex-negro-falda.jpg"]', '["ds-babydoll-04","ds-disfraz-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-babydoll-04', 'Babydoll Negro en Tul con Lazo de Satín Rojo', 'Babydoll', 67000, 46000, 1, 5, 125, 810, '["NUEVO","FAVORITO","BABYDOLL"]', 'Babydoll negro con copas en encaje trabajado y cuerpo de tul translúcido. Resalta una cinta y lazo frontal en satín rojo brillante de caída larga con ribete a juego.', '90% Poliamida, 10% Elastano con cinta de satín de seda.', '["S","M","L","XL","XXL"]', '["images/products/babydoll-negro-cinta-roja-satin.jpg"]', '["ds-corse-15","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-babydoll-03', 'Babydoll Negro Escote Hombros Descubiertos con Vuelo', 'Babydoll', 67000, 46000, 1, 4.9, 96, 620, '["NUEVO","EXCLUSIVO","BABYDOLL"]', 'Diseño estilo campesino con escote elástico de hombros descubiertos adornado con volantes delicados, cordón de ajuste frontal y falda amplia de caída ligera.', '88% Poliéster, 12% Spandex elástico de alta suavidad.', '["S","M","L","XL","XXL"]', '["images/products/babydoll-negro-hombros-descubiertos.jpg"]', '["ds-corse-15","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-babydoll-02', 'Babydoll Negro con Tiras Geométricas y Encaje', 'Babydoll', 67000, 46000, 1, 4.9, 118, 760, '["NUEVO","TENDENCIA","BABYDOLL"]', 'Elegante babydoll negro en tul semitransparente con copas de encaje festoneado y tiras cruzadas decorativas en la parte superior. Falda holgada con ribete de encaje en el ruedo.', '92% Poliamida, 8% Elastano.', '["S","M","L","XL","XXL"]', '["images/products/babydoll-negro-tiras-cruzadas.jpg"]', '["ds-corse-15","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-babydoll-01', 'Babydoll Rojo Vino con Vuelos y Encaje Floral', 'Babydoll', 67000, 46000, 1, 5, 142, 890, '["NUEVO","MÁS VENDIDO","BABYDOLL"]', 'Babydoll confeccionado en tul ligero y encaje floral en tono rojo vino. Cuenta con copas triangulares estructuradas, lazo frontal y falda fluida con acabado en vuelos.', '90% Poliamida, 10% Spandex. Tejido extra suave al tacto y elástico.', '["S","M","L","XL","XXL"]', '["images/products/babydoll-rojo-vuelos-encaje.jpg"]', '["ds-corse-15","ds-bralette-07"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-06', 'Disfraz Temático Colegiala Manga Larga con Falda Escocesa', 'Disfraces', 72000, 50000, 1, 4.9, 104, 510, '["NUEVO","DISFRACES","DESTACADO"]', 'Conjunto temático estilo estudiante compuesto por crop top blanco manga larga con lazo frontal y detalle a cuadros, acompañado de minifalda tableada escocesa roja con ligueros decorativos.', '90% Poliéster, 10% Spandex transpirable y flexible.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-colegiala-manga-larga.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-05', 'Conjunto Temático Cuerotex Negro con Arnés Decorativo', 'Disfraces', 72000, 50000, 1, 5, 135, 680, '["NUEVO","DISFRACES","ESTILO URBANO"]', 'Conjunto temático en acabado efecto piel / cuerotex negro. Cuenta con top estructurado, arnés superior cruzado con cadena metálica decorativa y falda acampanada de tiro alto.', 'Cuerotex sintético flexible de alta calidad con forro interior suave.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-cuerotex-arnes-negro.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-04', 'Disfraz Temático Enfermera Clásica con Ribetes Rojos', 'Disfraces', 72000, 50000, 1, 4.8, 94, 470, '["NUEVO","DISFRACES","MÁS PEDIDO"]', 'Conjunto temático de enfermera en tela blanca con ribetes rojos. Incluye top tipo halter con cruz bordada, minifalda con encaje y lazos decorativos, y manguitos a juego.', '88% Poliamida, 12% Spandex. Tejido liviano y cómodo.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-enfermera-clasica.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-03', 'Disfraz Temático Fantasía Roja en Vinilo Charol con Guantes', 'Disfraces', 72000, 50000, 1, 4.9, 76, 390, '["NUEVO","DISFRACES","EDICIÓN ESPECIAL"]', 'Conjunto temático confeccionado en vinilo charol rojo brillante. Incluye top con cordones ajustables al frente, minifalda con volantes superpuestos y guantes largos mitones.', '95% Poliéster con acabado vinilo brillante, 5% Spandex elástico.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-fantasia-vinilo-rojo.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-02', 'Disfraz Temático Mucama Francesa en Satín y Encaje', 'Disfraces', 72000, 50000, 1, 4.9, 112, 560, '["NUEVO","DISFRACES","FAVORITO"]', 'Conjunto temático tipo mucama que incluye top corsetero negro con ribetes de encaje blanco, minifalda roja satinada con vuelos y delantal decorativo con bordado.', '92% Poliamida, 8% Elastano con apliques en encaje suave.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-mucama-francesa.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

INSERT INTO `productos` (`id`, `name`, `category`, `regularPrice`, `salePrice`, `isFlashSale`, `rating`, `reviewsCount`, `salesCount`, `tags`, `description`, `composition`, `sizes`, `images`, `crossSellIds`)
VALUES ('ds-disfraz-01', 'Disfraz Temático Colegiala con Tirantes y Falda Escocesa', 'Disfraces', 72000, 50000, 1, 5, 88, 420, '["NUEVO","DISFRACES","TENDENCIA"]', 'Conjunto temático de 4 piezas que incluye crop top negro de anudar, tirantes elásticos ajustables, corbata y minifalda tableada con estampado escocés clásico.', '90% Poliéster, 10% Elastano. Confección suave y elástica de fácil ajuste.', '["S","M","L","XL","XXL"]', '["images/products/disfraz-colegiala-tirantes.jpg"]', '["ds-corse-15","ds-bailarina-06"]')
ON DUPLICATE KEY UPDATE 
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `regularPrice` = VALUES(`regularPrice`),
  `salePrice` = VALUES(`salePrice`),
  `description` = VALUES(`description`),
  `images` = VALUES(`images`),
  `sizes` = VALUES(`sizes`);

