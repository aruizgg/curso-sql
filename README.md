# curso-sql

> Curso de Bases de Datos Relacionales con MySQL

---

## **Ejercicio 1: Lista de tareas**

Queremos hacer una aplicación donde cada usuario disponga de una lista para añadir tareas y marcarlas como completadas. Los usuarios se registrarán mediante correo y contraseña, aunque también nos interesa almacenar su nombre completo. Para cada tarea, queremos almacenar su título, descripción, estado (completada o no completada) y fecha límite para completarla.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_1/Conceptual.png)

</details>  

<details>
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_1/Lógico.png)

</details>  
<details>
  <summary><strong>Diseño Físico</strong></summary>

  ``` 
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
  ```

</details>     

---

## **Ejercicio 2: Taxis**

Queremos almacenar información sobre los taxistas y vehículos que conducen en nuestra provincia. De cada taxista queremos saber su nombre y número de teléfono, y de cada vehículo queremos saber su marca, modelo y número de matrícula. Aparte de estos datos, necesitamos almacenar unas cuantas imágenes del vehículo para tener un seguimiento de los accidentes o desperfectos.

Además, en la provincia existen varios garajes/parkings donde se estacionarán los vehículos una vez terminada la jornada laboral. Cada parking tiene una dirección y nos interesa saber qué vehículos están estacionados en los parkings en un momento dado.

Cada vehículo solo puede ser utilizado al mismo tiempo por un taxista, y nuestra aplicación permitirá definir el periodo en el cual dicho taxista conduce el vehículo, por ejemplo desde el 12 de abril de 2022 hasta el 16 de octubre de 2022.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_2/Conceptual.png)

</details>  

<details>
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_2/Lógico.png)

</details>     

<details>
  <summary><strong>Diseño Físico</strong></summary>

  ``` 
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
  ```
</details> 

---

## **Ejercicio 3: Chat Rooms**

Queremos desarrollar una aplicación donde los usuarios puedan crear salas de chat y asignar distintos roles a cada miembro de la sala. Los usuarios se registrarán mediante correo y contraseña, aunque también almacenaremos su nombre completo y dispondrán de un nombre de usuario único.

Cada sala tiene un dueño (el usuario que la ha creado inicialmente), un nombre y una descripción. La sala podrá configurarse como privada, de forma que solo aquellos que tengan una invitación podrán unirse. La invitación deberá ser un enlace generado automáticamente. En caso de que la sala sea pública no es necesaria una invitación para unirse.

Los dueños de las salas podrán crear roles y asignarlos a otros usuarios. De cada rol queremos almacenar el nombre y una descripción.

Finalmente, queremos almacenar la fecha incluyendo hora y minuto de cada mensaje que se envía en cada sala, así como el usuario que lo ha enviado.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_3/Conceptual.png)

</details>  

<details>
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_3/Lógico.png)

</details>      

---

## **Ejercicio 4: Seguros**

Nuestra empresa necesita almacenar datos sobre sus clientes y los seguros que han adquirido. De cada cliente queremos saber el número de su documento de identidad y su nombre completo.

Los seguros pueden cubrir gastos de reparación en caso de daños para propiedades (casas, apartamentos, etc.) o para vehículos. En el caso de las propiedades nos interesa almacenar los metros cuadrados totales de la propiedad así como su dirección, mientras que en el caso de los vehículos queremos almacenar su precio de compra y su número de matrícula. Estos datos nos servirán para calcular el coste anual del seguro que deberá pagar el cliente.

El cliente podrá elegir cuál es el porcentaje de los gastos totales de reparación que cubrirá el seguro al contratarlo, por ejemplo un 40%. Este dato también será necesario para calcular el precio anual.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_4/Conceptual.png)

</details>

<details> 
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_4/Lógico.png)

</details>  

---

## **Ejercicio 5: Departamentos y empleados**

Nuestra empresa cuenta con varias oficinas situadas en edificios diferentes y en cada una de ellas se encuentran distintos departamentos. Los edificios tienen un número asociado, que es único entre los edificios de la misma ciudad pero puede repetirse para edificios de ciudades distintas.

Sobre los departamentos queremos almacenar su nombre, que es único, su número de departamento, que también es único, y su presupuesto anual. Por otro lado, queremos saber en qué departamento trabaja cada empleado, para lo cual disponemos de su número de empleado, que es único dentro de cada departamento, pero puede repetirse para empleados de diferentes departamentos. Y para terminar, los empleados pueden tener a su cargo a otros empleados, queremos almacenar esta información.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_5/Conceptual.png)

</details>  

<details>    
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_5/Lógico.png)

</details>  


---

## **Ejercicio 6: Red social**

Vamos a desarrollar una aplicación similar a Instagram donde los usuarios podrán subir posts a su perfil y seguir a otros usuarios.

Los usuarios se registrarán con correo y contraseña, pero tendrán que elegir un nombre de usuario único y una imagen de perfil (la imagen es opcional) para completar el registro. Si los datos son válidos se les creará automáticamente un perfil al registrarse.

Un usuario puede seguir los perfiles de otros usuarios para ver su contenido, y puede subir posts a su perfil para que otros usuarios los vean. Cada post puede tener como máximo 10 imágenes, dispondrá también de una descripción opcional y almacenaremos la fecha de creación del post.

Los usuarios podrán escribir comentarios en los posts de otros usuarios o en sus propios posts. De cada comentario nos interesa almacenar el texto y la fecha en la que se ha publicado.

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Ejercicio_6/Conceptual.png)

</details> 
<details>    
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Ejercicio_6/Lógico.png)

</details>   

---

## **Reto: Ecommerce**

Queremos crear un marketplace similar a Amazon donde los usuarios puedan crear tiendas y vender sus productos online. Los usuarios se registrarán con correo y contraseña y almacenaremos además su nombre completo.

De cada tienda queremos almacenar su nombre y el usuario al que pertenece, así como los productos que vende. Para cada producto almacenaremos su nombre, una descripción, el *stock* actual, el precio actual y el descuento actual. Además, es posible que algunos productos cuenten con distintos tamaños y colores (por ejemplo, un monitor puede estar disponible en distintas resoluciones y pulgadas), por lo tanto queremos permitir a los usuarios almacenar esta información. Finalmente, cada producto contará con al menos una imagen o varias. Los productos son únicos para cada tienda, es decir, aunque haya varias tiendas vendiendo el mismo producto, cada una de ellas tiene que crearlo por separado en la aplicación y añadir su nombre, imágenes, etc.

Los usuarios, además de vender, podrán comprar productos de otras tiendas. Para ello, tendrán que crear un pedido del cual almacenaremos los productos que incluye, la cantidad de cada producto, el color y tamaño de cada producto (si es el caso), el precio de cada producto (ya que puede cambiar en el futuro) y el descuento aplicado (también podrá cambiar en el futuro). Calcularemos también el precio total de la compra y añadiremos un número de factura para poder enviarlo al comprador más tarde.

Además, necesitamos saber a dónde enviar el paquete, de forma que los usuarios podrán asociar a su cuenta varias direcciones de envío y elegir una de ellas al crear un pedido. La dirección estará compuesta por los siguientes campos: país, provincia, ciudad, calle, número y, opcionalmente, unidad (número de apartamentos, puerta, etc.). Esta dirección la almacenaremos junto con los otros campos del pedido. Por último, como el pedido puede tardar varios días en prepararse, enviarse y llegar a su destino, queremos almacenar su estado ("procesando", "enviado", "entregado", "cancelado").

<details>
  <summary><strong>Diseño Conceptual</strong></summary>

  ![Conceptual.png](Reto/Conceptual.png)

</details>  
<details>    
  <summary><strong>Diseño Lógico</strong></summary>

  ![Lógico.png](Reto/Lógico.png)

</details>  

---

## **Proyecto final: App de pagos**

Queremos hacer una aplicación similar a PayPal donde los usuarios dispongan de cuentas con saldo y puedan hacer transferencias a otros usuarios. Los usuarios se registrarán mediante correo y contraseña, aunque almacenaremos también su nombre completo.

Cada usuario podrá crear varias cuentas, que pueden ser normales o de empresa. Para cada cuenta, almacenamos su saldo actual en €, su nombre y una descripción proporcionada por el usuario.

Si la cuenta es normal, no almacenamos más información asociada a ella. Sin embargo, si la cuenta es de empresa, almacenaremos el nombre de la empresa y su número de identificación fiscal o *tax ID*.

De cada transferencia que ocurre entre las cuentas de los usuarios nos interesa almacenar la cantidad transferida, la fecha incluyendo hora y minuto y el estado de la transferencia, que puede ser "pagado" o "reembolsado".

Del mismo modo, los usuarios podrán transferir dinero desde sus cuentas de la aplicación a sus cuenta bancarias, o recibir dinero desde su banco para aumentar el saldo en la app. Por lo tanto, el usuario podrá asociar varias cuentas bancarias a cada cuenta creada en la aplicación. De las cuentas bancarias queremos almacenar su número de cuenta.

Para cada transferencia que ocurre entre un banco y nuestra app queremos saber la dirección en la que se ha transferido el dinero (si se ha hecho desde la app al banco o viceversa). Además, como las transferencia bancarias pueden tardar varios días queremos saber su estado ("procesando", "completada", "cancelada"), así como la fecha de emisión de la transferencia y la fecha de finalización (cuando se ha completado o cancelado).