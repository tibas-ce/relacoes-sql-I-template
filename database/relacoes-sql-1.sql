

-- Pratica 2 - Relação de 1:m (um para muitos)
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE phones (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    phone_number TEXT UNIQUE NOT NULL,
    user_id TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) 
);

SELECT * FROM users;

INSERT INTO users (id, name, email, password)
VALUES
("u001", "Fulano", "fulano@email.com", "as12345"),
("u002", "Fulana", "fulana@email.com", "qw12354");

INSERT INTO phones VALUES
("p001", "9123568", "u001"),
("p002", "9875461", "u002"),
("p003", "9987456", "u002");

-- criando query que juntas as duas tabelas
SELECT * FROM users 
INNER JOIN phones 
ON phones.user_id = users.id;

-- escolhendo que informações vão ser acessadas
SELECT users.name, phones.phone_number FROM users 
INNER JOIN phones 
ON phones.user_id = users.id;

-- Prática 3 - Relação 1:1

CREATE TABLE licenses(
    id TEXT UNIQUE NOT NULL,
    register_number TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL
);

SELECT * FROM licenses;

CREATE TABLE drivers(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    license_id TEXT UNIQUE NOT NULL,
    FOREIGN KEY(license_id) REFERENCES licenses(id)
);

SELECT * FROM drivers;

INSERT INTO licenses VALUES
("l001", "123456", "B"),
("l002", "654321", "A"),
("l003", "987456", "AB");

INSERT INTO drivers VALUES
("d001", "Fulano", "fulano@email.com", "1234", "l002"),
("d002", "Fulana", "fulana@email.com", "4321", "l003"),
("d003", "Cicrano", "cicrano@email.com", "6543", "l001");

-- query de junção das tabelas
SELECT * FROM drivers
INNER JOIN licenses
ON licenses.id = license_id;

-- só com name, register_number, category
SELECT drivers.name, licenses.register_number, licenses.category FROM drivers
INNER JOIN licenses
ON licenses.id = license_id;

-- FIXAÇÃO
-- Relação de 1:m
CREATE TABLE requests (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    request_number TEXT UNIQUE NOT NULL,
    user_id TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO requests VALUES
("r001", "1523", "u001"),
("r002", "1235", "u002"),
("r003", "1485", "u001"),
("r004", "5555", "u002");

-- escolhendo que informações vão ser acessadas
SELECT users.name, requests.request_number FROM users 
INNER JOIN requests 
ON requests.user_id = users.id;

-- Relação de m:m
-- Sistemas de bancos de dados relacionais normalmente não permitem implementar um relacionamento muitos para muitos direto entre duas tabelas.
-- Para evitar esse problema você pode dividir o relacionamento muitos para muitos em dois relacionamentos um para muitos usando uma terceira tabela, chamada de tabela de associação.
CREATE TABLE students(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE classes (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO students VALUES
("s001", "Fulano", "Silva"),
("s002", "Fulana", "Santos"),
("s003", "Cicrano", "Silva"),
("s004", "Cicrana", "Santos");

INSERT INTO classes VALUES
("c001", "HTML", "Fundamentos"),
("c002", "CSS", "Fundamentos"),
("c003", "Java-Script", "Fundamentos"),
("c004", "REACT", "Fundamentos"),
("c005", "Type-Script", "Fundamentos");

-- Tabela de associação
CREATE TABLE registration (
   id TEXT PRIMARY KEY UNIQUE NOT NULL,
   student_id TEXT NOT NULL,
   class_id TEXT NOT NULL,
   FOREIGN KEY(student_id) REFERENCES students(id),
   FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO registration VALUES
("r001", "s001", "c001"),
("r002", "s001", "c002"),
("r003", "s001", "c003"),
("r004", "s002", "c004"),
("r005", "s003", "c004"),
("r006", "s003", "c005"),
("r007", "s004", "c003");

-- Todos os valores
SELECT * FROM registration
INNER JOIN students
ON students.id = student_id
INNER JOIN classes
ON classes.id = class_id;

-- Apenas id da matricula, nome do aluno e aula escolhida
SELECT registration.id AS Matriculas, students.name, classes.title  FROM registration
INNER JOIN students
ON students.id = student_id
INNER JOIN classes
ON classes.id = class_id;