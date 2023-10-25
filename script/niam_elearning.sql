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
    created_at TIMESTAMP null default null,
    updated_at TIMESTAMP null,
    primary key (id),
    FOREIGN KEY (idRole) REFERENCES user_roles(id)
);

create table students(
	id int not null auto_increment,
    name VARCHAR(255) not null,
	email CHAR(255) not null,
    password CHAR(100) not null,
    phone CHAR(10) null default null,
    status TINYINT not null DEFAULT 1,
    remember_token CHAR(80) null DEFAULT null,
    created_at TIMESTAMP null DEFAULT null,
    updated_at TIMESTAMP null,
    PRIMARY key (id)
);

create table user_roles (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
    primary key(id)
);

-- --------------------------------------------------

create table educations (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
    primary key(id)
);

-- course_edu <=> cate

create table categrories (
	id int auto_increment,
    name varchar(255),
    idEdu int not null,
    status boolean default 1,
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
    primary key(id)
);

alter TABLE categrories
add FOREIGN KEY (idEdu) REFERENCES educations(id);

create table course (
	id int auto_increment,
    name varchar(255) not null,
	summary varchar(255) DEFAULT null,
    price int not null,
    image char(200) null DEFAULT null,
    discount int null DEFAULT null,
	idCate int not null,
    duration int not null,
    grade VARCHAR(100) null DEFAULT null,
	status boolean default 1,
	description text,
    created_at TIMESTAMP null DEFAULT null,
    updated_at TIMESTAMP null,
    primary key(id)
);

alter table course
add FOREIGN KEY (idCate) REFERENCES categrories(id);

-- -------------------------------------------------

create table schedules (
	id int auto_increment,
    schedule text,
    idTeacher int not null,
    idCourse int not null,
	created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
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
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
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
	duration int not null,
    pass int not null,
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
    primary key(id)
);

alter table process
add FOREIGN KEY (idCourse) REFERENCES course(id);

create table process_detail (
	id int not null auto_increment,
    idProcess int not null,
    idStudent int not null,
    created_at TIMESTAMP null,
    updated_at TIMESTAMP null,
    primary key(id)
);

ALTER TABLE process_detail
add FOREIGN KEY (idProcess) REFERENCES process(id);

ALTER TABLE process_detail
add FOREIGN KEY (idStudent) REFERENCES students(id);

-- --------------------------------------------------------

use niam_elearning;
ALTER TABLE users
add FOREIGN KEY (idRole) REFERENCES user_roles(id);

-- --------------------------------------------------------
use niam_elearning;
select * from niam_elearning.users_role;

-- Hàm:
select current_timestamp();

insert into user_roles(name, created_at)
values ('customer', (current_timestamp()));

-- Hàm:
SELECT FLOOR(RAND() * (9999 - 1 + 1)) + 1;

-- insert_role----------------------------------
insert into user_roles(name, created_at)
values('admin', (current_timestamp()));

insert into user_roles(name, created_at)
values('teacher', (current_timestamp()));

insert into user_roles(name, created_at)
values('student', (current_timestamp()));



ALTER TABLE user_roles
ADD CONSTRAINT  UNIQUE (name);

-- insert_users--------------------------------------------------------
INSERT INTO users(name, email, idRole, password, created_at)
VALUES('nam', 'name@gmail.com', 3, '12345', (current_timestamp()));

INSERT INTO users(name, email, idRole, password, created_at)
VALUES('admin', 'admin@gmail.com', 1, '12345', (current_timestamp()));

INSERT INTO users(name, email, idRole, password, created_at)
VALUES('teacher', 'teacher@gmail.com', 2, '12345', (current_timestamp()));

INSERT INTO users(name, email, idRole, password, created_at)
VALUES('alien', 'alien@gmail.com', 3, FLOOR(RAND() * (9999 - 1 + 1)) + 1, (current_timestamp()));

-- insert_edu-------------------------------------------------------------
insert into educations(name, created_at)
values
	('Chương trình IELTS',(current_timestamp())),
	('Chương trình phổ thông quốc tế Cambridge',(current_timestamp())),
	('Chương trình lập trình',(current_timestamp()));
    
-- insert_course-----------------------------------------------------
INSERT INTO course (name, summary, price, idCate, duration, description)
VALUES 
	('Toán Học 10', 'Tóm tắt', 500, 2, 80, 'Mô tả'),
    ('Tiếng Anh', 'Tóm tắt', 300, 1, 30, 'Mô tả'),
    ('NMTH', 'Tóm tắt', 800, 3, 50, 'Mô tả');
    
-- insert_schedules--------------------------------------------------
insert into schedule()
VALUEs
	();
-- insert_cate--------------------------------------------------
insert into categrories(name, idEdu, created_at)
values
	('KHTN', 2, (current_timestamp())),
    ('Ngoại Ngữ', 1, (current_timestamp())),
    ('Tin Học', 3, (current_timestamp()));


-- insert_students------------------------------------------------
INSERT into students(name , email, password, created_at)
values
	('nam', 'nam@gmail.com', '12345', (current_timestamp())),
    ('alien', 'alien@gmail.com', '12345', (current_timestamp())),
    ('abc', 'abc@gmail.com', '12345', (current_timestamp()));