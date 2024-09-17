create table likes (

    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    usuarioid INT,
    productoid INT,
    FOREIGN KEY (usuarioid) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (productoid) REFERENCES productos(id) ON DELETE CASCADE
);



