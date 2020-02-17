CREATE DATABASE tiidelab;
USE tiidelab;
CREATE TABLE fellows(
	id INTEGER (10) NOT NULL AUTO_INCREMENT,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
     
    primary key (id)
    );
    
    INSERT INTO fellows( first_name, last_name)
		VALUES('Shittu', 'Yasir'); 
	insert into fellows(first_name, last_name)
        values( 'Bello', 'Ahmed');
        insert into fellows(first_name, last_name)
        values( 'Umoh', 'Esther');
create table account (
id integer (10) NOT NULL auto_increment,
account_number INTEGER(10) NOT NULL,
ballance decimal(10,2) NOT NULL,
user_id integer (10),
primary key (id),
foreign key (user_id) references fellows (id)

);

Alter TABLE account CHANGE COLUMN account_number account_number varchar(10) NOT NULL;
insert into account( id, account_number, ballance, user_id  )
	values('1', '1234556789', '4566.677', '1');
    insert into account( id, account_number, ballance, user_id  )
	values('2', '1234553449', '43676.677', '2');
    insert into account( id, account_number, ballance, user_id  )
	values('3', '8234556789', '5566.67', '1');
    
    select * from fellows 
    JOIN account ON account.user_id = fellows.id ;
    
    
use tiidelab;
CREATE TABLE transactions(
	id integer(10) NOT NULL auto_increment,
    amount decimal(10,2) NOT NULL,
    descriptions varchar(30) NOT NULL,
    trans_type	varchar(6) NOt NULL,
    trans_date	timestamp default current_timestamp on update current_timestamp,
    primary key(id),
    user_fk_id integer(10) NOT NULL,
    foreign key(user_fk_id) references fellows (id )
    );
    
    
    select first_name, last_name, account_number, ballance, trans_type, trans_date, amount, descriptions
    from fellows, account, transactions
    where fellows.id= transactions.user_fk_id order by trans_date;
    
     select first_name, last_name, trans_type, descriptions
    from fellows, transactions 
    where fellows.id= transactions.user_fk_id AND trans_type='credit';
    
	select first_name, last_name, trans_type, descriptions
    from fellows, transactions 
    where fellows.id= transactions.user_fk_id AND trans_type='debit';
    