DROP DATABASE IF EXISTS ejercicio_3;

CREATE DATABASE ejercicio_3;

USE ejercicio_3;

CREATE TABLE users (

    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE rooms (
    
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    is_private BOOLEAN NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE user_room (
    
    user_id INT UNSIGNED NOT NULL,
    room_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (user_id, room_id),

    FOREIGN KEY(user_id) REFERENCES users(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY(room_id) REFERENCES rooms(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE messages (
    
    user_id INT UNSIGNED NOT NULL,
    room_id INT UNSIGNED NOT NULL,
    content VARCHAR (512) NOT NULL,
    date DATETIME NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY(room_id) REFERENCES rooms(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE invitations (
    
    user_id INT UNSIGNED NOT NULL,
    room_id INT UNSIGNED NOT NULL,
    url VARCHAR (255) NOT NULL,


    PRIMARY KEY (user_id, room_id),

    FOREIGN KEY(user_id) REFERENCES users(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY(room_id) REFERENCES rooms(id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE roles (
    
    id SERIAL PRIMARY KEY,
    room_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,

    FOREIGN KEY(room_id) REFERENCES rooms(id) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);