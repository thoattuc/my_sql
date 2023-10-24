create database db_niam character set utf8mb4 collate utf8mb4_unicode_ci;

use db_niam;

CREATE TABLE users(
	id int not null auto_increment,
    name varchar(255) not null,
    email varchar(255) not null,
    status tinyint not null default 1,
    password char(80) not null,
    remember_token varchar(80) null default null,
    idRole int(11) not null,
    create_at TIMESTAMP null default null,
    update_at TIMESTAMP null,
    primary key (id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

create table user_roles (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

create table educations (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table categrories (
	id int auto_increment,
    name varchar(255),
    status boolean default 1,
    idEducation int not null,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table course (
	id int auto_increment,
    name varchar(255),
    duration TIME,
    price int not null,
    discount int null,
    summary varchar(255),
	status boolean default 1,
	description text,
    idCate int not null,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table schedules (
	id int auto_increment,
    idCourse int not null,
    time TIMESTAMP,
    idUser int not null,
	create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table bills (
	id int auto_increment,
    idSchedule int not null,
    create_at TIMESTAMP null,
    update_at TIMESTAMP null,
    primary key(id)
);

create table process (
	id int auto_increment,
    idTeacher int not null,
    idSchedule int not null,
	duration TIME,
    primary key(id)
);

create table detail (
	id int auto_increment,
    id_student int not null,
    primary key(id)
);