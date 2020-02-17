create database kabo_air ;
use kabo_air;

create table travelers(
traveler_id integer (10) NOT NULL auto_increment,
 fname varchar(20) NOT NULL,
lname varchar(20) NOT NULL,
bod date NOT NULL,
phonen_number  varchar(11) NOT NULL,
email varchar(25) NOT NULL,
address varchar(40) NOT NULL,
primary key (traveler_id)
);

create table dependance( -- travelers may have children or infant or another adult
	dep_id integer(7) NOt NULL auto_increment,
    fname varchar(20) NOT NULL,
    lname varchar(20) NOT NULL,
    bod date NOT NULL, 
    category varchar(10) NOT NULL, 
    owner_fk integer(10) NOT NULL,
    primary key (dep_id),
    foreign key(owner_fk) references travelers(traveler_id)
);

create table class_category( -- either first class business class or economy class
	class_id integer(1) NOT NULL AUTO_INCREMENT,
    class_type varchar(15) NOT NULL,
    primary key(class_id)
	);
create table airport(	-- this houses the from and to destinations
	port_id integer(3) NOT NULL,
    port_name varchar(40) NOT NULL,
    port_location varchar (20) NOT NULL,
    primary key(port_id)
);
create table flight_schedule( 
	schedule_id integer(10) NOT NULL AUTO_INCREMENT,
    from_where integer(3) NOT NULL,
    to_where integer(3) NOT NULL,
    seat_available integer (3) NOT NULL,
    flight_num varchar (5) NOT NULL,
    flight_time time NOT NULL,
    primary key(schedule_id),
	foreign key(from_where) references airport(port_id),
    foreign key(to_where) references airport(port_id)
);
create table weighted_value ( -- this reconciles the travelers choice of class, dependancy, is it  a one way trip or return
	value_id integer (10) NOT NULL AUTO_INCREMENT,
    traveler_fk integer (10) NOT NULL,
    ticket_class integer (1) NOT NULL,
    dependance_num integer (7) NOT NULL,
    -- journey_type integer(1) NOT NULL
    primary key(value_id),
    foreign key(traveler_fk) references travelers(traveler_id),
    foreign key(ticket_class) references class_category(class_id),
    foreign key(dependance_num) references dependance(dep_id)
);
create table trip_type( -- return or one way  
trip_id integer (1) NOT NULL,
trip_type varchar(15) NOT NULL,
primary key(trip_id)
);
create table cost(
cost_id integer(10) NOT NULL AUTO_INCREMENT,
weighted_fk integer(10) NOT NULL,
flight_fk integer(10) NOT NULL,
amount decimal(8,2) NOT NULL,
primary key(cost_id),
foreign key(weighted_fk) references weighted_value(value_id),
foreign key(flight_fk) references flight_schedule(schedule_id)

);
create table ticket(
	ticket_id integer(20) NOT NULL AUTO_INCREMENT,
    cost_fk integer(10)  NOT NULL,
    departure_date date NOT NULL,
    is_valid boolean default true,
    primary key(ticket_id),
    foreign key (cost_fk) references cost(cost_id)
);
alter table weighted_value 
add trip_cat integer(1) ;
alter table weighted_value 
add constraint foreign key(trip_cat) references trip_type (trip_id);
describe weighted_value;

alter table weighted_value 
modify trip_cat integer(1) NOT NUll;
