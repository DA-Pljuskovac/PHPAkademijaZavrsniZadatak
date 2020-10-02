USE polaznik13;
create table `user` (
    id int not null primary key auto_increment,
    first_name varchar (50) not null,
    last_name varchar (50) not null,
    email varchar (50) not null,
    pass char(60) not null,
    user_type tinyint not null
);
create unique index emailindex on user(email);

CREATE TABLE movie(
    mov_id int not null primary key auto_increment,
    mov_title varchar(50),
    mov_rating varchar(10),
    mov_year int,
    mov_time int,
    mov_lang varchar(50),
    mov_dt_rel date,
    mov_desc text,
    mov_trailer varchar (255)
);

create table actor(
    act_id int not null primary key auto_increment,
    act_fname varchar(50),
    act_lname varchar(50),
    act_gender char(1),
    mov_id int,
    role varchar (30),
    foreign key (mov_id) references movie(mov_id)
);

create table director(
    dir_id int not null primary key auto_increment,
    dir_fname varchar(50),
    dir_lname varchar (50),
    mov_id int,
    foreign key (mov_id) references  movie(mov_id)
);

create table movie_genres(
    mov_id int,
    genre varchar(35),
    foreign key (mov_id) references movie(mov_id)
);

create table review(
    rev_id int not null primary key auto_increment,
    rev_name varchar(60),
    rev_content text,
    rev_score int,
    rev_mov_id int not null,
    rev_up int,
    rev_down int,
    user_type tinyint,
    user_id int,
    foreign key (rev_mov_id) references movie(mov_id),
    foreign key (user_id) references user(id)
);

create table has_voted(
    user_id int,
    mov_id int,
    rev_id int,
    voted int,
    foreign key (user_id) references user(id),
    foreign key (rev_id) references review(rev_id),
    foreign key (mov_id) references movie(mov_id)
);

create table movie_watchlist(
    user_id int,
    mov_id int,
    mov_title varchar(255),
    foreign key (user_id) references user(id),
    foreign key (mov_id) references movie(mov_id)
);