create table if not exists tbl_user
(
	id serial primary key,
	email varchar(100) not null unique,
	username varchar(100) not null unique,
	password varchar(100) not null,
	status varchar(1) default 'A',
	create_date timestamp,
	update_date timestamp
);
comment on column tbl_user.status is 'A = ACTIVE, I = INACTIVE, D=DELETE';
insert into tbl_user(email, username, "password", status, create_date, update_date)
values
('superadmin@emeeting.com', 'superadmin', 'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'
,'A', now(), now()),
('admin@emeeting.com', 'admin', 'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'
,'A', now(), now()),
('user@emeeting.com', 'user', 'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'
,'A', now(), now());

-- superadmin password P@ssw0rd use sha256

create table if not exists tbl_role
(
	id serial primary key,
	name varchar(50),
	create_date timestamp,
	update_date timestamp
);
insert into tbl_role(name, create_date, update_date)
values
('ADMIN', now(), now()),
('USER', now(), now());

create table if not exists tbl_user_role
(
	id serial primary key,
	user_id bigint,
	role_id bigint,
	constraint fk_tbl_user_role_user_id foreign key(user_id) references tbl_user(id),
	constraint fk_tbl_user_role_role_id foreign key(role_id) references tbl_role(id)
);
insert into tbl_user_role(user_id, role_id)
values(2, 1),(3, 2);
create type room_available as enum('in use', 'empty');
create table if not exists tbl_room
(
	id serial primary key,
	name varchar(100),
	capacity int,
	status ROOM_AVAILABLE,
	create_date timestamp,
	update_date timestamp
);
insert into tbl_room(name, capacity, status, create_date, update_date)
values
('Meeting Room 101', 20, 'empty', now(), null),
('Meeting Room 102', 20, 'empty', now(), null);

create type order_status as enum('submission', 'approve', 'reject', 'on going', 'finish');

create table if not exists tbl_order(
	id serial primary key,
	room_id bigint,
	order_date timestamp,
	time_start time,
	time_end time,
	status ORDER_STATUS,
	create_date timestamp,
	update_date timestamp
);