create database niam_elearning character set utf8mb4 collate utf8mb4_unicode_ci;

use niam_elearning;

CREATE TABLE users(
	id int not null auto_increment,
    name varchar(255) not null,
    email varchar(255) not null,
	idRole int(11) not null,
    phone char(10) null default null,
    status tinyint not null default 1,
    password char(80) not null,
    remember_token varchar(80) null default null,
    create_at TIMESTAMP null default null,
    update_at TIMESTAMP null,
    primary key (id),
    FOREIGN KEY (idRole) REFERENCES user_roles(id)
);

create table user_roles (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

-- --------------------------------------------------

create table educations (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table course_edu (
	id int auto_increment,
    name varchar(255),
    idEdu int not null,
    status boolean default 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

alter TABLE course_edu
add FOREIGN KEY (idEdu) REFERENCES educations(id);

create table course (
	id int auto_increment,
    name varchar(255) not null,
	summary varchar(255) DEFAULT null,
    price int not null,
    image char(200) DEFAULT null,
    discount int null,
	idCoEd int not null,
    duration int not null,
    grade VARCHAR(100),
	status boolean default 1,
	description text,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

alter table course
add FOREIGN KEY (idCoEd) REFERENCES course_edu(id);

-- -------------------------------------------------

create table schedules (
	id int auto_increment,
    schedule text,
    idTeacher int not null,
    idCourse int not null,
    idUser int not null,
	create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

alter TABLE schedules
add FOREIGN KEY (idCourse) REFERENCES course(id);

-- --------------------------------------------

create table bills (
	id int auto_increment,
    name varchar(255),
    email CHAR(255),
    phone CHAR(10),
    idSchedule int not null,
    status BOOLEAN DEFAULT 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

alter table bills
add FOREIGN KEY (idSchedule) REFERENCES schedules(id);

create table process (
	id int auto_increment,
    name VARCHAR(255),
    idTeacher int not null,
	schedules CHAR(255),
    idCourse int not null,
	duration TIME,
    pass int not null,
    primary key(id)
);

alter table process
add FOREIGN KEY (idCourse) REFERENCES course(id);

create table process_user (
	id int auto_increment,
    idProcess int not null,
    idUser int not null,
    primary key(id)
);

ALTER TABLE process_user
add FOREIGN KEY (idProcess) REFERENCES process(id);

ALTER TABLE process_user
add FOREIGN KEY (idUser) REFERENCES users(id);

-- --------------------------------------------------------

use niam_elearning;
ALTER TABLE users
add FOREIGN KEY (idRole) REFERENCES user_roles(id);

-- --------------------------------------------------------
use niam_elearning;
select * from niam_elearning.users_role;

-- Hàm:
select current_timestamp();

insert into user_roles(name, create_at)
values ('customer', (current_timestamp()));

-- Hàm:
SELECT FLOOR(RAND() * (9999 - 1 + 1)) + 1;



insert into user_roles(name, create_at)
values('admin', (current_timestamp()));

insert into user_roles(name, create_at)
values('user', (current_timestamp()));

insert into user_roles(name, create_at)
values('customer', (current_timestamp()));

ALTER TABLE user_roles
ADD CONSTRAINT  UNIQUE (name);

-- -------------------------------------------------------------

INSERT INTO users(name, email, idRole, password, create_at)
VALUES('nam', 'name@gmail.com', 2, '12345',(current_timestamp()));

INSERT INTO users(name, email, idRole, password, create_at)
VALUES('admin', 'admin@gmail.com', 1, '12345',(current_timestamp()));

INSERT INTO users(name, email, idRole, password, create_at)
VALUES('abc', 'abc@gmail.com', 2, '12345',(current_timestamp()));

INSERT INTO users(name, email, idRole, password, create_at)
VALUES('alien', 'alien@gmail.com', 3, '12345',(current_timestamp()));

-- ---------------------------------------------------------------

insert into educations(name, create_at)
values
	('Chương trình IELTS',(current_timestamp())),
	('Chương trình phổ thông quốc tế Cambridge',(current_timestamp())),
	('Chương trình lập trình',(current_timestamp()));
