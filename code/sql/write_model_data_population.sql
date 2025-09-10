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

--1. Tabella sex_types
--insert into sex_types (cod,sex_type_name)
--	values('F', 'Sesso Femminile');

--insert into sex_types (cod,sex_type_name)
--	values('M', 'Sesso Maschile');

--insert into sex_types (cod,sex_type_name)
--	values('U', 'Non voglio dichiarare il mio sesso');

--select * from sex_types;


----2. Tabella continents
--insert into continents (cod, continent_name) values ('AF', 'Africa');
--insert into continents (cod, continent_name) values ('AS', 'Asia');
--insert into continents (cod, continent_name) values ('EU', 'Europa');
--insert into continents (cod, continent_name) values ('NA', 'America del Nord');
--insert into continents (cod, continent_name) values ('SA', 'America del Sud');
--insert into continents (cod, continent_name) values ('OC', 'Oceania');

--select * from continents


----3. Tabella Countries
--select @continent_id = id from continents where cod = 'EU';
--insert into countries (cod, continent_id, country_name) VALUES ('ITA',@continent_id,'Italy');
--insert into countries (cod, continent_id, country_name) VALUES ('FRA',@continent_id,'France');

--select @continent_id = id from continents where cod = 'NA';
--insert into countries (cod, continent_id, country_name) VALUES ('USA',4,'United States');
--insert into countries (cod, continent_id, country_name) VALUES ('PAN',4,'Panama');


--select * from countries;
--select n.*, c.continent_name
--from countries n
--inner join continents c on n.continent_id = c.id

----4. Tabella cities
--select * from countries

--select @country_id = id from countries where cod = 'ITA';
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'RM', 'Rome');
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'MI', 'Milan');
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'TS', 'Trieste');
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'PA', 'Palermo');

--select @country_id = id from countries where cod = 'USA';
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Miami');
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Boston');

--select @country_id = id from countries where cod = 'FRA';
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Paris');

--select @country_id = id from countries where cod = 'PAN';
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,null, 'Panama');

--select ci.*, co.country_name
--from cities ci
--inner join countries co on ci.country_id = co.id;

----5. Tabella airports
--select * from cities

----FCO
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'FCO',id,'Aeroporto di Roma-Fiumicino','via dell''Aeroporto di Fiumicino,Roma'
--from cities where city_name = 'Roma'; 

----LIN
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'LIN',id,'Aeroporto di Milano-Linate','via Enrico Forlanini, Milano'
--from cities where city_name = 'Milan'; 


----TRS
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'TRS',id,'Aeroporto di Trieste-Ronchi dei Legionari','Via Aquileia 46, Ronchi dei Legionari'
--from cities where city_name = 'Trieste'; 


----MIA
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'MIA',id,'Aeroporto di Miami','via dell''Aeroporto di Fiumicino,Roma'
--from cities where city_name = 'Miami'; 


----CGD
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'CDG',id,'Aeroporto di Parigi-Charles de Gaulle','95700 Roissy-en-France'
--from cities where city_name = 'Paris'; 


----PTY
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'PTY',id,'Tocumen International Airport','Avenida Domingo Díaz, Panama City, Panama'
--from cities where city_name = 'Panama'; 


----BOS
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'BOS',id,'Aeroporto di Boston Logan','1 Harborside Dr'
--from cities where city_name = 'Boston'; 


----PMO
--insert into airports (iata_airport_code, city_id, airport_name, airport_address)
--select 'PMO',id,'Aeroporto di Palermo-Punta Raisi','Cinisi, Palermo'
--from cities where city_name = 'Palermo';


--select a.*, c.city_name
--from airports a 
--inner join cities c on a.city_id = c.id;

