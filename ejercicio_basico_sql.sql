-- ============================================================
-- EJERCICIO BÁSICO DE SQL - Portafolio GitHub
-- Autor: Tu nombre
-- Descripción: Gestión simple de una tienda de libros
-- ============================================================


-- ============================================================
-- 1. CREAR TABLAS
-- ============================================================

CREATE TABLE autores (
    id        INTEGER PRIMARY KEY,
    nombre    TEXT    NOT NULL,
    pais      TEXT
);

CREATE TABLE libros (
    id         INTEGER PRIMARY KEY,
    titulo     TEXT    NOT NULL,
    autor_id   INTEGER REFERENCES autores(id),
    precio     DECIMAL(6,2),
    stock      INTEGER DEFAULT 0,
    anio       INTEGER
);


-- ============================================================
-- 2. INSERTAR DATOS
-- ============================================================

INSERT INTO autores (id, nombre, pais) VALUES
    (1, 'Gabriel García Márquez', 'Colombia'),
    (2, 'Jorge Luis Borges',      'Argentina'),
    (3, 'Isabel Allende',         'Chile');

INSERT INTO libros (id, titulo, autor_id, precio, stock, anio) VALUES
    (1, 'Cien años de soledad',     1, 15.99, 10, 1967),
    (2, 'El amor en los tiempos...',1,  12.50,  5, 1985),
    (3, 'Ficciones',                2,  9.99, 20, 1944),
    (4, 'El Aleph',                 2, 10.50, 15, 1949),
    (5, 'La casa de los espíritus', 3, 13.75,  8, 1982);


-- ============================================================
-- 3. CONSULTAS BÁSICAS (SELECT)
-- ============================================================

-- Todos los libros
SELECT * FROM libros;

-- Solo título y precio, ordenados de menor a mayor precio
SELECT titulo, precio
FROM libros
ORDER BY precio ASC;

-- Libros con precio mayor a 12
SELECT titulo, precio
FROM libros
WHERE precio > 12;


-- ============================================================
-- 4. JOIN - Combinar tablas
-- ============================================================

-- Mostrar título del libro junto con el nombre del autor
SELECT
    l.titulo,
    a.nombre AS autor,
    a.pais,
    l.precio
FROM libros l
JOIN autores a ON l.autor_id = a.id;


-- ============================================================
-- 5. FUNCIONES DE AGRUPACIÓN
-- ============================================================

-- Cuántos libros tiene cada autor
SELECT
    a.nombre AS autor,
    COUNT(l.id) AS total_libros
FROM autores a
LEFT JOIN libros l ON a.id = l.autor_id
GROUP BY a.nombre
ORDER BY total_libros DESC;

-- Precio promedio de todos los libros
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM libros;

-- Libro más caro y más barato
SELECT
    MAX(precio) AS mas_caro,
    MIN(precio) AS mas_barato
FROM libros;


-- ============================================================
-- 6. UPDATE y DELETE
-- ============================================================

-- Actualizar stock de un libro
UPDATE libros
SET stock = 25
WHERE titulo = 'Ficciones';

-- Borrar un registro (ejemplo - no rompe nada)
-- DELETE FROM libros WHERE id = 5;


-- ============================================================
-- 7. CONSULTA EXTRA: filtrar con LIKE
-- ============================================================

-- Buscar libros cuyo título empiece con "El"
SELECT titulo FROM libros
WHERE titulo LIKE 'El%';
