- ---------------------------------------------------------------------
-- Этап 4. Вход в приложение (чек-лист 2.5, 2.6, 3.17)
-- ---------------------------------------------------------------------
SELECT u.id, u.full_name, r.name AS role
FROM users u
JOIN roles r ON r.id = u.role_id
WHERE u.login = '94d5ous@gmail.com' AND u.password = 'uzWC67';

-- ---------------------------------------------------------------------
-- Этап 5. Каталог товаров — окно Гостя и Администратора (2.7–2.11)
-- ---------------------------------------------------------------------
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.quantity,
p.description, p.photo, c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id;

-- ---------------------------------------------------------------------
-- Этап 6. Поиск + фильтр + сортировка (3.2–3.6)
-- ---------------------------------------------------------------------

-- 6.1. Всё вместе: поиск по названию + фильтр по поставщику + сортировка по остатку
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.quantity,
p.description, p.photo,
c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id
WHERE p.name LIKE '%Ботинки%' AND p.supplier_id = 1
ORDER BY p.quantity DESC;

-- 6.2. Только поиск (3.1)
SELECT * FROM products p 
WHERE p.name LIKE '%стол%' AND p.supplier_id = 1
ORDER BY p.stock_qty DESC;

-- 6.3. Только фильтр по поставщику (3.4–3.5)
SELECT * FROM products p 
WHERE p.supplier_id = 1;

-- 6.4. Только сортировка по остатку (3.2–3.3): по возрастанию / по убыванию
-- по возрастанию 
SELECT * FROM products p 
WHERE p.name LIKE '%стол%' AND p.supplier_id = 1
ORDER BY p.stock_qty ASC;

-- по убыванию
SELECT * FROM products p 
WHERE p.name LIKE '%стол%' AND p.supplier_id = 1
ORDER BY p.stock_qty DESC;

-- ---------------------------------------------------------------------
-- Этап 7. Добавление и редактирование товара (3.7, 3.10, 3.12, 3.19)
-- ---------------------------------------------------------------------

-- Справочники для выпадающих списков формы
SELECT id, name FROM categories;
SELECT id, name FROM manufacturers;
SELECT id, name FROM suppliers;

-- Добавление товара (3.7)
INSERT INTO products
  (article, name, unit, price, discount, quantity, description, photo,
   category_id, manufacturer_id, supplier_id)
VALUES
  ('R100K1', 'Сандали', 'шт.', 3200, 5, 10,
   'Сандалии kari женские летние, размер 38, цвет: белый', '', 1, 1, 1);

-- Открыть товар для редактирования — заполнить все поля формы (3.10)
SELECT * FROM products WHERE id = 3;

-- Сохранить изменения (3.12, 3.19)
UPDATE products
SET article = 'R100K1', name = 'Сандалии', unit = 'шт.', price = 3500,
    discount = 10, quantity = 25,
    description = 'Сандалии Rieker мужские летние, размер 42, цвет: коричневый',
    photo = '', category_id = 2, manufacturer_id = 6, supplier_id = 2
WHERE article = 'R100K1';

-- ---------------------------------------------------------------------
-- Этап 8. Удаление товара и защита от удаления купленного (3.16)
-- ---------------------------------------------------------------------

-- Проверка 
SELECT COUNT(*) AS used_in_orders FROM prodorders WHERE product_id = 1;
-- Удаление
DELETE FROM products WHERE id = 1;