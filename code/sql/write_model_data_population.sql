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

----1. Tabella sex_types
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
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'RM', 'Miami');
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'MI', 'Boston');

--select @country_id = id from countries where cod = 'FRA';
--insert into cities (country_id, area_local_code, city_name) VALUES (@country_id,'RM', 'Paris');

--select ci.*, co.country_name
--from cities ci
--inner join countries co on ci.country_id = co.id;
