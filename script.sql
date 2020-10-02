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

/* movies */
insert into movie values
     (1,'THE LODGE','R',2019,108,'English','2020-02-7',
     'A soon-to-be stepmom is snowed in with her fiancé''s two children at a remote holiday village. Just as relations begin to thaw between the trio, some strange and frightening events take place.','https://www.youtube.com/embed/XYUI97qAa_k'),
     (2,'THE GENTLEMEN','R',2019,113,'English','2020-01-24','An American expat tries to sell off his highly profitable marijuana empire in London, triggering plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.','https://www.youtube.com/embed/vaN8BtA8OJk'),
     (3,'MULAN','PG-13',2020,116,'English','2020-09-4','A young Chinese maiden disguises herself as a male warrior in order to save her father.','https://www.youtube.com/embed/KK8FHdFluOQ'),
     (4,'SUMMERLAND','PG',2020,113,'English','2020-07-31','During World War II, an Englishwoman (Gemma Arterton) opens her heart to an evacuee after initially resolving to be rid of him in this moving journey of womanhood, love and friendship.','https://www.youtube.com/embed/vh6xso8QAys'),
     (5,'BAD BOYS FOR LIFE','R',2020,124,'English','2020-01-17','Detectives Mike Lowrey and Marcus Burnett join the Miami Police Department''s special team AMMO to bring down the ruthless Armando, who is on a mission to kill Mike at his mother Isabel''s orders.','https://www.youtube.com/embed/jKCj3XuPG8M'),
     (6,'BUFFALOED','E',2020,95,'English','2020-02-14','Set in the underworld of debt-collecting and follows the homegrown hustler Peg Dahl, who will do anything to escape Buffalo, NY.','https://www.youtube.com/embed/qcoeLQ-E4gc'),
     (7,'THE GODFATHER','R',1972,177,'English','1972-04-14','The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.','https://www.youtube.com/embed/sY1S34973zA'),
     (8,'LOGAN','R',2017,137,'English','2017-03-02','In a future where mutants are nearly extinct, an elderly and weary Logan leads a quiet life. But when Laura, a mutant child pursued by scientists, comes to him for help, he must get her to safety.','https://www.youtube.com/embed/Div0iP65aZo'),
     (9,'BLADE RUNNER','R',1982,117,'English','1982-06-25','A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.','https://www.youtube.com/embed/KPcZHjKJBnE');


/*Directors                            */
insert into director values
                (1,'Veronika', 'Franz',1),
                (2,'Severin', 'Fiala',1),
                (3,'Guy', 'Ritchie',2),
                (4,'Niki', 'Caro',3),
                (5,'Jessica', 'Swale',4),
                (6,'Adil', 'El Arbi',5),
                (7,'Bilall', 'Fallah',5),
                (8,'Tanya', 'Wexler',6),
                (9,'Francis Ford', 'Coppola',7),
                (10,'James', 'Mangold',8),
                (11,'Ridley', 'Scott',9);




/* Actors */
insert into actor values
                            (1,'Riley', 'Keough','F',1,'Grace'),
                            (2,'Jaeden', 'Martell','M',1,'Aidan'),
                            (3,'Lia', 'McHugh','F',1,'Mia') ,
                            (4,'Alicia', 'Silverstone','F',1,'Laura'),
                            (5,'Richard', 'Armitage','M',1,'Richard') ,

                            (6,'Stephen','Graham','M',2,'Michael Pearson'),
                            (7,'Matthew', 'McConaughey','M',2,'Ray') ,
                            (8,'Charlie', 'Hunnam','M',2,'Dry Eye') ,
                            (9,'Henry', 'Golding','M',2,'Rosalind Pearson') ,
                            (10,'Michelle', 'Dockery','F',2,'Matthew') ,

                            (11,'Yifei', 'Liu','F',3,'Mulan') ,
                            (12,'Donnie', 'Yen','M',3,'Commander Tung') ,
                            (13,'Jason Scott', 'Lee','M',3,'Bori Khan') ,
                            (14,'Li', 'Gong','F',3,'Li Gong') ,
                            (15,'Jet', 'Li','M',3,'The Emperor') ,

                            (16,'Gemma', 'Arterton','F',4,'Alice') ,
                            (17,'Gugu', 'Mbatha-Raw','F',4,'Vera') ,
                            (18,'Tom', 'Courtenay','M',4,'Mr. Sullivan') ,
                            (19,'Penelope', 'Wilton','F',4,'Older Alice') ,
                            (20,'Lucas', 'Bond','M',4,'Frank') ,
                            (21,'Dixie', 'Egerickx','F',4,'Edie') ,
                            (22,'Amanda', 'Root','F',4,'Amanda Root') ,

                            (23,'Will', 'Smith','M',5,'Mike Lowrey') ,
                            (24,'Martin', 'Lawrence','M',5,'Marcus Burnett') ,
                            (25,'Vanessa', 'Hudgens','F',5,'Kelly') ,
                            (26,'Alexander', 'Ludwig','M',5,'Dorn') ,
                            (27,'Charles', 'Melton','M',5,'Rafe') ,
                            (28,'Paola', 'Nunez','F',5,'Rita') ,
                            (29,'Kate', 'del Castillo','F',5,'Isabel') ,
                            (30,'Joe', 'Pantoliano','M',5,'Captain Howard') ,

                            (31,'Zoey', 'Deutch','F',6,'Peg Dahi') ,
                            (32,'Judy', 'Greer','F',6,'Kathy') ,
                            (33,'Jai', 'Courtney','M',6,'Wizz') ,
                            (34,'Jermaine', 'Flower','M',6,'Graham') ,
                            (35,'Lusia', 'Strus','F',6,'Frances') ,
                            (36,'Noah', 'Reid','M',6,'JJ') ,
                            (37,'Jayne', 'Eastwoord','F',6,'Rhonda') ,
                            (38,'Raymond', 'Ablack','M',6,'Prakash') ,
                            (39,'Brian', 'Sacca','M',6,'Sal') ,
                            (40,'Nicholas', 'Carella','M',6,'Mitch') ,

                            (41,'Marlon', 'Brando','M',7,'Don Vito Corleone'),
                            (42,'Al', 'Pacino','M',7,'Michael Corleone'),
                            (43,'James', 'Caan','M',7,'Sonny Corleone'),
                            (44,'Richard', 'Castellano','M',7,'Clemenza'),
                            (45,'Robert', 'Duvall','M',7,'Tom Hagan'),
                            (46,'Sterling', 'Hayden','M',7,'Capt. McCluskey'),
                            (47,'John', 'Marley','M',7,'Jack Woltz'),
                            (48,'Richard', 'Conte','M',7,'Barzini'),
                            (49,'Diane', 'Keaton','F',7,'Kay Adams'),

                            (50,'Hugh', 'Jackman','M',8,'Logan'),
                            (51,'Patrick', 'Stewart','M',8,'Charles'),
                            (52,'Dafne', 'Keen','F',8,'Laura'),
                            (53,'Boyd', 'Holbrook','M',8,'Pierce'),
                            (54,'Elizabeth', 'Rodriguez','F',8,'Gabriela'),
                            (55,'Richard E.', 'Grant','M',8,'Dr. Rice'),
                            (56,'Eriq La', 'Salle','M',8,'Will Munson'),
                            (57,'Elise', 'Neal','F',8,'Kathryn Munsom'),

                            (58,'Harrison', 'Ford','M',9,'Rick Deckard'),
                            (59,'Rutger', 'Hauer','M',9,'Roy Batty'),
                            (60,'Sean', 'Young','F',9,'Rachael'),
                            (61,'Edward James', 'Olmos','M',9,'Gaff'),
                            (62,'Daryl', 'Hannah','F',9,'Pris'),
                            (63,'William', 'Sanderson','M',9,'J.F. Sebastian'),
                            (64,'Brion', 'James','M',9,'Leon Kowalski'),
                            (65,'Joe', 'Turkel','M',9,'Dr. Eldon Tyrell');

insert into movie_genres values
(1,'Drama'),
(1,'Horror'),
(1,'Thriller'),
(2,'Action'),
(2,'Comedy'),
(2,'Crime'),
(3,'Action'),
(3,'Comedy'),
(3,'Crime'),
(4,'Drama'),
(4,'Romance'),
(4,'War'),
(5,'Action'),
(5,'Comedy'),
(6,'Comedy'),
(7,'Crime'),
(7,'Drama'),
(8,'Action'),
(8,'Drama'),
(8,'Sci-Fi'),
(8,'Thriller'),
(9,'Action'),
(9,'Sci-fi'),
(9,'Thriller');

insert into user values (1,'Domagoj-Antonio','Pljuskovac','pljuskovac.domagojantonio@gmail.com','1111155555',3);