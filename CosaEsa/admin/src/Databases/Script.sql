CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'peoples';
GRANT CREATE USER ON *.* TO 'admin_user'@'localhost'; 

CREATE ROLE 'productos_categorias';

GRANT SELECT, INSERT, UPDATE, DELETE ON ventaspeople.colores_producto TO 'admin_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ventaspeople.producto TO 'admin_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ventaspeople.tipoproducto TO 'productos_categorias';

GRANT 'productos_categorias' TO 'admin_user'@'localhost' WITH GRANT OPTION;
GRANT 'productos_categorias' TO 'admin_user'@'localhost' WITH ADMIN OPTION;

CREATE ROLE 'consultar_usuarios';
GRANT SELECT, INSERT, UPDATE, DELETE ON ventaspeople.usuario TO 'admin_user'@'localhost';

GRANT 'consultar_usuarios' TO 'admin_user'@'localhost';
SHOW GRANTS FOR 'admin_user'@'localhost'
SHOW GRANTS FOR 'productos_categorias'
SHOW GRANTS FOR 'consultar_usuarios'
FLUSH PRIVILEGES;

INSERT INTO usuario (name, email, password, Nombres, ApellidoPrimero, ApellidoSegundo, role, verificado) VALUES ('pepe', 'ddre', '12345', 'san', 'san', 'san', 'admin', 1)

SELECT * FROM usuario
