DROP DATABASE IF EXISTS ejercicio_4;

CREATE DATABASE ejercicio_4;

USE ejercicio_4;

CREATE TABLE clients (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_document_number VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE insurances (
    
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_id INT UNSIGNED NOT NULL,
    percentage_covered TINYINT UNSIGNED NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    annual_cost DECIMAL(8, 2) NOT NULL,
    type ENUM("VEHICLE", "PROPERTY"),

    FOREIGN KEY(client_id) REFERENCES clients(id) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CHECK (percentage_covered <= 100)
);

CREATE TABLE vehicles (
    
    insurance_id INT UNSIGNED NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    plate_number VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY(insurance_id) REFERENCES insurances(id) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE properties (
    
    insurance_id INT UNSIGNED NOT NULL,
    area DECIMAL (5,2) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    unit VARCHAR(255),

    FOREIGN KEY(insurance_id) REFERENCES insurances(id) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);