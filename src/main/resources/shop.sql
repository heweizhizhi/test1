drop database if exists shop;

create database shop default character set utf8;

use shop;

create table t_product_type(
	id int primary key auto_increment,
	name varchar(100)
);

insert into t_product_type (name) values ('服装');
insert into t_product_type (name) values ('家电');
insert into t_product_type (name) values ('手机');
insert into t_product_type (name) values ('珠宝');
insert into t_product_type (name) values ('汽车');
insert into t_product_type (name) values ('游戏');

create table t_product(
	id int primary key auto_increment,
	name varchar(100),
	price double,
	image varchar(100), -- 商品图片的路径
	`desc` varchar(2000), -- 商品的描述
	product_type_id int,
	foreign key (product_type_id) references t_product_type (id)
);

insert into t_product (name, price, image, `desc`, product_type_id) values ('ins外套', 268.0, '/images/1.jpg', 'ins外套男秋季嘻哈运动棒球服情侣休闲宽松潮牌夹克ulzzang冲锋衣', 1);
insert into t_product (name, price, image, `desc`, product_type_id) values ('稻草人休闲裤', 119.0, '/images/2.jpg', '稻草人休闲裤男2019秋装新款男士运动裤束脚裤子大码弹力男裤跑步卫裤 黑色 K919 XL', 1);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p1', 1.1, '/images/hotaddress1.jpeg', 'describe111111', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p2', 2.2, '/images/hotaddress1.jpeg', 'describe222222', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p3', 3.3, '/images/hotaddress1.jpeg', 'describe333333', 3);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p4', 4.4, '/images/hotaddress1.jpeg', 'describe444444', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p4', 5.5, '/images/hotaddress1.jpeg', 'describe555555', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p5', 6.6, '/images/hotaddress1.jpeg', 'describe666666', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p6', 7.7, '/images/hotaddress1.jpeg', 'describe777777', 3);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p7', 8.8, '/images/hotaddress1.jpeg', 'describe888888', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p8', 9.9, '/images/hotaddress1.jpeg', 'describe999999', 2);
insert into t_product (name, price, image, `desc`, product_type_id) values ('p9', 10.10, '/images/hotaddress1.jpeg', 'describe999999', 4);

create table t_user(
	id int primary key auto_increment,
	nick_name varchar(100),
	username varchar(100),
	password varchar(100),
	phone varchar(20), 
	address varchar(200),
	image varchar(100) -- 用户头像的路径
);

insert into t_user (nick_name, username, password, phone, address) values ('老何', 'admin', '123', '110', 'adresssadresss');

create table t_order(
	id int primary key auto_increment,
	no varchar(100),
	total_price double,-- 订单总价
	user_id int,
	foreign key (user_id) references t_user (id)
);

create table t_item(
	id int primary key auto_increment,
	product_id int,
	num int,
	total_price double, -- 明细总价
	create_time datetime,
	order_id int,
	foreign key (product_id) references t_product(id),
	foreign key (order_id) references t_order (id)
);







