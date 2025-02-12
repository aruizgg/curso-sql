DROP DATABASE IF EXISTS ejercicio_1;

CREATE DATABASE ejercicio_1;

USE ejercicio_1;

CREATE TABLE users (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE tasks (
    
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    status ENUM("COMPLETED", "IN PROGRESS", "NOT COMPLETED") NOT NULL,
    due_date DATETIME NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);