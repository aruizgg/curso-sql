DROP DATABASE IF EXISTS ejercicio_2;

CREATE DATABASE ejercicio_2;

USE ejercicio_2;

CREATE TABLE drivers (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL
);


CREATE TABLE parkings (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL
);

CREATE TABLE vehicles (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parking_id INT UNSIGNED,
    plate_number VARCHAR(255) NOT NULL UNIQUE,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,

    FOREIGN KEY (parking_id) REFERENCES parkings(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE vehicle_image (

    vehicle_id INT UNSIGNED,
    url VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE driver_verhicle (

    driver_id INT UNSIGNED NOT NULL PRIMARY KEY,
    vehicle_id INT UNSIGNED NOT NULL UNIQUE,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,


    FOREIGN KEY (driver_id) REFERENCES drivers(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);