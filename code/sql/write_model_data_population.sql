/**********
Nome Script		write_model_data_population.sql
Autore			Fabio Vitaterna
Descrizione		Popolamento dei dati di test del modello
Note			Se il modello già esiste, è opportuno ricrearlo tramite lo script write_model.sql per evitare duplicazioni di dati
**********/

use db_abdf0e_fvitapegaso

go

--dichiarazione variabili
declare @continent_id tinyint;
declare @country_id tinyint;
declare @id_airline smallint;
declare @id_fare_type int;
declare @idfare_type_option int;

/*
declare @continent_id tinyint;
declare @country_id tinyint;
declare @id_airline smallint;
declare @id_fare_type int;
declare @idfare_type_option int;



--1. Tabella sex_types
insert into sex_types (cod,sex_type_name)
	values('F', 'Sesso Femminile');

insert into sex_types (cod,sex_type_name)
	values('M', 'Sesso Maschile');

insert into sex_types (cod,sex_type_name)
	values('U', 'Non voglio dichiarare il mio sesso');

select * from sex_types;


--2. Tabella continents
insert into continents (cod, continent_name) values ('AF', 'Africa');
insert into continents (cod, continent_name) values ('AS', 'Asia');
insert into continents (cod, continent_name) values ('EU', 'Europa');
insert into continents (cod, continent_name) values ('NA', 'America del Nord');
insert into continents (cod, continent_name) values ('SA', 'America del Sud');
insert into continents (cod, continent_name) values ('OC', 'Oceania');

select * from continents


--3. Tabella Countries
select @continent_id = id from continents where cod = 'EU';
insert into countries (cod, continent_id, country_name) VALUES ('ITA',@continent_id,'Italy');
insert into countries (cod, continent_id, country_name) VALUES ('FRA',@continent_id,'France');

select @continent_id = id from continents where cod = 'NA';
insert into countries (cod, continent_id, country_name) VALUES ('USA',4,'United States');
insert into countries (cod, continent_id, country_name) VALUES ('PAN',4,'Panama');


select * from countries;
select n.*, c.continent_name
from countries n
inner join continents c on n.continent_id = c.id

--4. Tabella cities
select * from countries

select @country_id = id from countries where cod = 'ITA';
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'RM', 'Rome');
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'MI', 'Milan');
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'TS', 'Trieste');
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'PA', 'Palermo');
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'NA', 'Napoli');

select @country_id = id from countries where cod = 'USA';
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Miami');
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Boston');

select @country_id = id from countries where cod = 'FRA';
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Paris');

select @country_id = id from countries where cod = 'PAN';
insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Panama');

select ci.*, co.country_name
from cities ci
inner join countries co on ci.country_id = co.id;

--5. Tabella airports
select * from cities

--FCO
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'FCO',id,'Aeroporto di Roma-Fiumicino','via dell''Aeroporto di Fiumicino,Roma'
from cities where city_name = 'Roma'; 

--LIN
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'LIN',id,'Aeroporto di Milano-Linate','via Enrico Forlanini, Milano'
from cities where city_name = 'Milan';

--NAP
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'NAP',id,'Aeroporto di Napoli-Capodichino','Viale F. Ruffo di Calabria, Napoli'
from cities where city_name = 'Milan';


--TRS
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'TRS',id,'Aeroporto di Trieste-Ronchi dei Legionari','Via Aquileia 46, Ronchi dei Legionari'
from cities where city_name = 'Trieste'; 


--MIA
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'MIA',id,'Aeroporto di Miami','via dell''Aeroporto di Fiumicino,Roma'
from cities where city_name = 'Miami'; 


--CGD
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'CDG',id,'Aeroporto di Parigi-Charles de Gaulle','95700 Roissy-en-France'
from cities where city_name = 'Paris'; 


--PTY
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'PTY',id,'Tocumen International Airport','Avenida Domingo Díaz, Panama City, Panama'
from cities where city_name = 'Panama'; 


--BOS
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'BOS',id,'Aeroporto di Boston Logan','1 Harborside Dr'
from cities where city_name = 'Boston'; 


--PMO
insert into airports (iata_airport_code, city_id, airport_name, airport_address)
select 'PMO',id,'Aeroporto di Palermo-Punta Raisi','Cinisi, Palermo'
from cities where city_name = 'Palermo';


select a.*, c.city_name
from airports a 
inner join cities c on a.city_id = c.id;

--6. Tabella airlines

--ITA Airways
insert into airlines (iata_airline_code, icao_airline_code,airline_name, id_country)
select 'AZ', 'ITY', 'ITA Airways', id
from countries
where cod = 'ITA';

--Air France
insert into airlines (iata_airline_code, icao_airline_code,airline_name, id_country)
select 'AF', 'AFR', 'Air France', id
from countries
where cod = 'FRA';


select a.*, c.country_name
from airlines a 
inner join countries c on a.id_country = c.id;

--7. Tabella flights
select @id_airline = id from airlines where iata_airline_code = 'AZ' --ITA Airways
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2010');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2016');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2028');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2034');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2080');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2050');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2056');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2114');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2130');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1263');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ2036');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1288');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1353');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1357');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1359');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1363');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ630');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ631');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ316');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ333');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1774');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ614');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ615');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AZ1777');


select @id_airline = id from airlines where iata_airline_code = 'AF' --Air France
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AF0474');
insert into flights (id_airline,iata_flight_code) VALUES (@id_airline,'AF0475');

select f.*, a.airline_name
from flights f inner join airlines a on f.id_airline = a.id;

--8. Table reservations_systems
insert into reservation_systems (reservation_system_code, reservation_system_name) values('ITA','Prenotazioni ITA Airways');
insert into reservation_systems (reservation_system_code, reservation_system_name) values('AMA','Amadeus');
insert into reservation_systems (reservation_system_code, reservation_system_name) values('SAB','Sabre');
insert into reservation_systems (reservation_system_code, reservation_system_name) values('GAL','Galileo');
insert into reservation_systems (reservation_system_code, reservation_system_name) values('WOR','Worldspan');

select * from reservation_systems;

--9. table fare_types
--10. table fare_type_options
--11. table fare_type_details

insert into fare_type_options (option_code) values ('HAND_LUGGAGE_DIM'); --dimensioni bagaglio a mano
--prezzo base per bagaglio in stiva (se = 0 il bagaglio in stiva sarà sempre gratuito per la tariffa collegata; se > 0 si tratta del prezzo base che potrà variare
--al momento dell'acquisto tramite calcoli applicativi legati a requisiti di eventuale dinamicizzaione della tariffa
insert into fare_type_options (option_code) values ('CHECKED_BAGGAGE_BASE_TAX');
insert into fare_type_options (option_code) values ('CHECKED_BAGGAGE_DIM'); --dimensioni bagaglio in stiva
--prezzo base per la scelta del posto (se = 0 la scelta sarà sempre gratuita per la tariffa collegata; se > 0 si tratta del prezzo base che potrà variare
--al momento dell'acquisto tramite calcoli applicativi legati a requisiti di eventuale dinamicizzaione della tariffa
insert into fare_type_options (option_code) values ('SEAT_SELECTION_TAX'); 
--Stesse considerazioni delle altre opzioni di tipo tax
insert into fare_type_options (option_code) values ('FLIGHT_CHANGE_TAX'); --penale per cambio volo
insert into fare_type_options (option_code) values ('REFUND_ALLOWED'); --rimborso permesso (Boolean: 0/1)
--Stesse considerazioni delle altre opzioni di tipo tax
insert into fare_type_options (option_code) values ('REFUND_TAX'); --tassa prevista per rimborso

--ITA Airways
select @id_airline = id from airlines where iata_airline_code = 'AZ';

--Economy Light
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOL','Economy Light');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOL';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '50'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '25'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '170'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Economy Classic
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOC','Economy Classic');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOC';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '25'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '120'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Economy Classic Plus
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOCP','Economy Classic Plus');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOCP';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '150'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Economy Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOF','Economy Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOF';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Premium Classic
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'PREC','Premium Classic');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'PREC';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '25'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '150'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Premium Full Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'PREF','Premium Full Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'PREF';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Business Classic
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'BUSC','Business Classic');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'BUSC';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x32Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '25'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Business Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'BUSF','Business Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'BUSF';

insert into fare_type_details
	select @id_fare_type, id, '1 x 8Kg + 1 accessorio'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x32Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';

select a.airline_name, 
	   ft.*,
	   fo.*,
	   fd.*
from fare_types ft
inner join airlines a on ft.id_airline = a.id
inner join fare_type_details fd on fd.id_fare_type = ft.id
inner join fare_type_options fo on fd.id_fare_type_option = fo.id
where a.iata_airline_code = 'AZ'


--Air France
select @id_airline = id from airlines where iata_airline_code = 'AF';

--Economy Light
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOL','Economy Light');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOL';

insert into fare_type_details
	select @id_fare_type, id, '55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '150'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '25'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '200'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Economy Standard
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOS','Economy Standard');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOS';

insert into fare_type_details
	select @id_fare_type, id, '55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '200'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Economy Standard Plus
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOSP','Economy Standard Plus');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOSP';

insert into fare_type_details
	select @id_fare_type, id, '55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';



--Economy Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'ECOF','Economy Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'ECOF';

insert into fare_type_details
	select @id_fare_type, id, '55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Premium Standard
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'PRES','Premium Standard');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'PRES';

insert into fare_type_details
	select @id_fare_type, id, '2 colli 55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';



--Premium Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'PREF','Premium Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'PREF';

insert into fare_type_details
	select @id_fare_type, id, '2 colli 55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x23Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';


--Business Standard
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'BUSS','Business Standard');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'BUSS';

insert into fare_type_details
	select @id_fare_type, id, '2 colli 55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x32Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';


--Business Flex
insert into fare_types (id_airline, fare_code, fare_name) values (@id_airline,'BUSF','Business Flex');

select @id_fare_type = id from fare_types where id_airline = @id_airline and fare_code = 'BUSF';

insert into fare_type_details
	select @id_fare_type, id, '2 colli 55 x 35 x 25 cm + 1 accessorio 40 x 30 x 15 cm'
	from fare_type_options
	where option_code = 'HAND_LUGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_BASE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '2x32Kg'
	from fare_type_options
	where option_code = 'CHECKED_BAGGAGE_DIM';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'SEAT_SELECTION_TAX';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'FLIGHT_CHANGE_TAX';

insert into fare_type_details
	select @id_fare_type, id, '1'
	from fare_type_options
	where option_code = 'REFUND_ALLOWED';

insert into fare_type_details
	select @id_fare_type, id, '0'
	from fare_type_options
	where option_code = 'REFUND_TAX';

select a.airline_name, 
	   ft.*,
	   fo.*,
	   fd.*
from fare_types ft
inner join airlines a on ft.id_airline = a.id
inner join fare_type_details fd on fd.id_fare_type = ft.id
inner join fare_type_options fo on fd.id_fare_type_option = fo.id
where a.iata_airline_code = 'AF'


--12. Table telephone_types
insert into telephone_types (cod, type_name) VALUES('H','Home');
insert into telephone_types (cod, type_name) VALUES('M','Mobile');
insert into telephone_types (cod, type_name) VALUES('B','Office');
select * from telephone_types;


--13 Table identity_document_types
insert into identity_document_types (cod, type_name) values ('ID', 'ID Card'); 
insert into identity_document_types (cod, type_name) values ('PS', 'Passport'); 
select * from identity_document_types;


--14. table airplanes
insert into airplanes (model) values ('AIRBUS A319');
insert into airplanes (model) values ('AIRBUS A318');
insert into airplanes (model) values ('AIRBUS A320');
insert into airplanes (model) values ('AIRBUS A321');
insert into airplanes (model) values ('AIRBUS A220-300');
insert into airplanes (model) values ('AIRBUS A220-100');
insert into airplanes (model) values ('AIRBUS A220 PASSENGER');
insert into airplanes (model) values ('AIRBUS A330-900NEO PASSENGER');
insert into airplanes (model) values ('AIRBUS A321NEO');
insert into airplanes (model) values ('AIRBUS A350-900');
insert into airplanes (model) values ('AIRBUS A330');
insert into airplanes (model) values ('AIRBUS A320NEO');
insert into airplanes (model) values ('BOEING 777');
select * from airplanes;



--15. table payment_tables
insert into payment_methods (cod,method_name) values ('CC', 'Credit Card');
insert into payment_methods (cod,method_name) values ('BK', 'Bank Transfer');
insert into payment_methods (cod,method_name) values ('PP', 'Paypal');
select * from payment_methods;

*/