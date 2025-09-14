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
declare @id_sex_type tinyint;
declare @id_telephone bigint;
declare @id_telephone_type tinyint;
declare @id_city smallint;
declare @id_fare_family tinyint;
declare @id_flight smallint;
declare @id_airplane int;

declare @j int;

declare @run_entire_script bit;

set @run_entire_script = 1;

begin try

	begin transaction

		if @run_entire_script = 0
		begin
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

		--9 table fare_family
		insert into fare_type_families (family_code,family_name) values ('E','Economy');
		insert into fare_type_families (family_code,family_name) values ('P','Premium');
		insert into fare_type_families (family_code,family_name) values ('B','Business');

		select * from fare_type_families;

		--10. table fare_types
		--11. table fare_type_options
		--12. table fare_type_details

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

		select @id_fare_family = id from fare_type_families where family_code = 'E';
		--Economy Light
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOL','Economy Light');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family ,@id_airline,'ECOC','Economy Classic');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOCP','Economy Classic Plus');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOF','Economy Flex');

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


		select @id_fare_family = id from fare_type_families where family_code = 'P';
		--Premium Classic
		insert into fare_types (id_fare_type_family,id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'PREC','Premium Classic');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'PREF','Premium Full Flex');

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


		select @id_fare_family = id from fare_type_families where family_code = 'B';
		--Business Classic
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'BUSC','Business Classic');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'BUSF','Business Flex');

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
			   fm.family_name,
			   ft.*,
			   fo.*,
			   fd.*
		from fare_types ft
		inner join fare_type_families fm on ft.id_fare_type_family = fm.id
		inner join airlines a on ft.id_airline = a.id
		inner join fare_type_details fd on fd.id_fare_type = ft.id
		inner join fare_type_options fo on fd.id_fare_type_option = fo.id
		where a.iata_airline_code = 'AZ'


		--Air France
		select @id_airline = id from airlines where iata_airline_code = 'AF';

		select @id_fare_family = id from fare_type_families where family_code = 'E';
		--Economy Light
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOL','Economy Light');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOS','Economy Standard');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOSP','Economy Standard Plus');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'ECOF','Economy Flex');

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


		select @id_fare_family = id from fare_type_families where family_code = 'P';
		--Premium Standard
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'PRES','Premium Standard');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'PREF','Premium Flex');

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


		select @id_fare_family = id from fare_type_families where family_code = 'B';
		--Business Standard
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'BUSS','Business Standard');

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
		insert into fare_types (id_fare_type_family, id_airline, fare_code, fare_name) values (@id_fare_family, @id_airline,'BUSF','Business Flex');

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
			   fm.family_name,
			   ft.*,
			   fo.*,
			   fd.*
		from fare_types ft
		inner join fare_type_families fm on ft.id_fare_type_family = fm.id
		inner join airlines a on ft.id_airline = a.id
		inner join fare_type_details fd on fd.id_fare_type = ft.id
		inner join fare_type_options fo on fd.id_fare_type_option = fo.id
		where a.iata_airline_code = 'AF'


		--13. Table telephone_types
		insert into telephone_types (cod, type_name) VALUES('H','Home');
		insert into telephone_types (cod, type_name) VALUES('M','Mobile');
		insert into telephone_types (cod, type_name) VALUES('B','Office');
		select * from telephone_types;


		--14 Table identity_document_types
		insert into identity_document_types (cod, type_name) values ('ID', 'ID Card'); 
		insert into identity_document_types (cod, type_name) values ('PS', 'Passport'); 
		select * from identity_document_types;


		--15. table airplanes
		insert into airplanes (model) values ('AIRBUS A319');
		insert into airplanes (model) values ('AIRBUS A318');
		insert into airplanes (model) values ('AIRBUS A320');
		insert into airplanes (model) values ('AIRBUS A321');
		insert into airplanes (model) values ('AIRBUS A220-300');
		insert into airplanes (model) values ('AIRBUS A220-100');
		--insert into airplanes (model) values ('AIRBUS A220 PASSENGER'); --> A220-300
		insert into airplanes (model) values ('AIRBUS A330-900NEO');
		insert into airplanes (model) values ('AIRBUS A321NEO');
		insert into airplanes (model) values ('AIRBUS A350-900');
		insert into airplanes (model) values ('AIRBUS A330-200');
		insert into airplanes (model) values ('AIRBUS A320NEO');
		insert into airplanes (model) values ('BOEING 777');
		select * from airplanes;



		--16. table payment_tables
		insert into payment_methods (cod,method_name) values ('CC', 'Credit Card');
		insert into payment_methods (cod,method_name) values ('BK', 'Bank Transfer');
		insert into payment_methods (cod,method_name) values ('PP', 'Paypal');
		select * from payment_methods;



		--17. table telephones
		insert into telephones (id_telephone_type,telephone_country_code,telephone_area_code, telephone_number)
			select id,'+39','345','35412749'
			from telephone_types
			where cod = 'M';

		select * from telephones;

		--18. Users

		select @id_sex_type =  id from sex_types where cod = 'M';
		select @id_city = id from cities where city_name = 'Rome';

		insert into users(
			user_name,
			password,
			first_name,
			last_name,
			birth_date,
			id_sex_type,
			email,
			id_telephone,
			address,
			zip_code,
			id_city,
			frequent_flyer_code,
			frequent_flyer_exp_date,
			frequent_flyer_point_balance)
		values(
			'fvitaterna_pegaso',
			'abcdrfghi',
			'Fabio',
			'Vitaterna',
			CAST('1968-09-13' as date),
			@id_sex_type,
			'fabio.vitaterna@studenti.unipegaso.it',
			1,
			'piazza Bologna 13',
			'000100',
			@id_city,
			'03770405',
			CAST('2025-12-31' as date),
			1000);

		select * from users;

		--19. price_components
		select @id_airline = id from airlines where iata_airline_code = 'AZ';
		
		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BASE','Base price for the flight');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'FUEL','Fuel Surcharge');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BAGGAGE','Baggage Security Fee');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'VAT','Value Added Tax');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'MUNICIPAL','Municipal Tax');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BOARDING','Boarding fee');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'PASS_SERV','Passengers Service');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'SECURITY','Security Fee');

		select @id_airline = id from airlines where iata_airline_code = 'AF';
		
		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BASE','Base price for the flight');


		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BAGGAGE','Baggage Security Fee');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'VAT','Value Added Tax');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'MUNICIPAL','Municipal Tax');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'BOARDING','Boarding fee');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'PASS_SERV','Passengers Service');

		insert into price_components (id_airline,price_component_code, price_component_name)
			values(@id_airline,'SECURITY','Security Fee');

		select a.airline_name, p.*
		from airlines a inner join price_components p on a.id = p.id_airline;


		--20.flight_schedule

		--Solo andata con 1 persona
		--		a. FCO-LIN  7:00-8:10 AZ2010 AIRBUS A319
		select @id_flight = id from flights where iata_flight_code = 'AZ2010';
		select @id_airplane = id from airplanes where model = 'AIRBUS A319';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('7:00' as time), cast('2025-11-24' as date), cast('8:10' as time));

		--Solo andata 1 persona con scali
		--a. 9:40-10:35  12:00-13:25 FCO-NAP-LIN AZ1263 + AZ1288 AIRBUS A220-100 + AIRBUS A319
		select @id_flight = id from flights where iata_flight_code = 'AZ1263';
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-100';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('9:40' as time), cast('2025-11-24' as date), cast('10:35' as time));

		select @id_flight = id from flights where iata_flight_code = 'AZ1288';
		select @id_airplane = id from airplanes where model = 'AIRBUS A319';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('12:00' as time), cast('2025-11-24' as date), cast('13:25' as time));

		--b. 18:00-19:10 - 20:00-20:55  FCO-LIN-TRS AZ2050 + AZ1353  AIRBUS A319 + AIRBUS A220-100
		select @id_flight = id from flights where iata_flight_code = 'AZ2050';
		select @id_airplane = id from airplanes where model = 'AIRBUS A319';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('18:00' as time), cast('2025-11-24' as date), cast('19:10' as time));

		select @id_flight = id from flights where iata_flight_code = 'AZ1353';
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-100';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('20:00' as time), cast('2025-11-24' as date), cast('20:55' as time));

		--Solo andata 2 persone
		--FCO-TRS 17:20-18:30; AZ1359; AIRBUS A220-300
		select @id_flight = id from flights where iata_flight_code = 'AZ1359';
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-300';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('17:30' as time), cast('2025-11-24' as date), cast('18:30' as time));


		--Andata/Ritorno 1 persona FCO-MIA
		--Andata 10:35-16:00 AZ630 AIRBUS A330-900NEO
		select @id_flight = id from flights where iata_flight_code = 'AZ630';
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-900NEO';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('10:35' as time), cast('2025-11-24' as date), cast('16:00' as time));
		--Ritorno 19:30-11:40 (+1 giorno) AZ631 AIRBUS A330-900NEO
		select @id_flight = id from flights where iata_flight_code = 'AZ631';
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-900NEO';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-12-01' as date), cast('19:30' as time), cast('2025-12-02' as date), cast('11:40' as time));


		--Andata/Ritorno 2 persone con parte in carico ad altro vettore
		--Andata
		--FCO-CGD  8:35-10:45 AZ316 AIRBUS A321NEO
		select @id_flight = id from flights where iata_flight_code = 'AZ316';
		select @id_airplane = id from airplanes where model = 'AIRBUS A320NEO';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('8:35' as time), cast('2025-11-24' as date), cast('10:45' as time));
		--CDG -PTY (Panama)  13:55-17:45 AF0474 AIRBUS A350-900
		select @id_flight = id from flights where iata_flight_code = 'AF0474';
		select @id_airplane = id from airplanes where model = 'AIRBUS A350-900';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('13:55' as time), cast('2025-11-24' as date), cast('17:45' as time));
		--Ritorno
		--PTY-CGD 19:55-13:15 (+1 giorno) - AF0475 - AIRBUS A350-900
		select @id_flight = id from flights where iata_flight_code = 'AF0475';
		select @id_airplane = id from airplanes where model = 'AIRBUS A350-900';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-12-01' as date), cast('19:55' as time), cast('2025-12-02' as date), cast('13:15' as time));
		--CGD-FCO 14:05-16:10 - AZ333 - AIRBUS A220-300
		select @id_flight = id from flights where iata_flight_code = 'AZ333';
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-300';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-12-02' as date), cast('14:05' as time), cast('2025-12-02' as date), cast('16:10' as time));


		--Andata/Ritorno 3 persone, 1 bambino,
		--Andata
		--PMO (Palermo) - FCO 7:20-8:30 - AZ1774 - AIRBUS A320
		select @id_flight = id from flights where iata_flight_code = 'AZ1774';
		select @id_airplane = id from airplanes where model = 'AIRBUS A320';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('7:20' as time), cast('2025-11-24' as date), cast('8:30' as time));
		--FCO - BOS 10:25-13:40 - AZ614 - AIRBUS A330-200
		select @id_flight = id from flights where iata_flight_code = 'AZ614';
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-200';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-11-24' as date), cast('10:25' as time), cast('2025-11-24' as date), cast('13:40' as time));
		--Ritorno
		--BOS-FCO 17:05-07:05 (+1 giorno) - AZ615 - AIRBUS A330-200
		select @id_flight = id from flights where iata_flight_code = 'AZ615';
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-200';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-12-01' as date), cast('17:05' as time), cast('2025-12-02' as date), cast('07:05' as time));
		--FCO-PMO 8:15-9:20 AZ1777 AIRBUS A320NEO
		select @id_flight = id from flights where iata_flight_code = 'AZ1777';
		select @id_airplane = id from airplanes where model = 'AIRBUS A320NEO';
		insert into flight_schedules (id_flight,id_airplane, departure_date, departure_time,arrival_date,arrival_time)
			values (@id_flight, @id_airplane, cast('2025-12-02' as date), cast('8:15' as time), cast('2025-12-02' as date), cast('9:20' as time));

		select f.iata_flight_code, a.model, fs.*
		from flight_schedules fs
		inner join flights f on fs.id_flight = f.id
		inner join airplanes a on fs.id_airplane = a.id;



		--21. airplane_seats
		--Configurazioni ITA Airways
		select @id_airline = id from airlines where iata_airline_code = 'AZ';

		--AIRBUS A319
		/*
		• https://www.aerolopa.com/az-319
		• Business: 2-8 AC DF (8 file per 4 posti: 32 posti totali)
		• Economy: 9-25 abc def (17 file per 6 posti: 102 posti totali)
		• Posti totali a disposizione: 134
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A319';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,2,8,'A,C,D,F';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,9,25,'A,B,C,D,E,F';
		
		--AIRBUS A220-100 
		/*
		• https://www.aerolopa.com/az-221
		• Business 1-6 AC DF (6 file per 4 posti: 24 totali)
		• Economy 7-27 AC DEF (21 file per 5 posti: 105 totali)
		• Posti totali a disposizione: 129
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-100';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,6,'A,C,D,F';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,7,27,'A,C,D,E,F';

		--AIRBUS A330-900NEO
		/*
		• https://www.aerolopa.com/az-359-3cl
		• Business
			§ 1 AD H (1 fila per 3 posti: 3)
			§ 2-8 AD HL (7 file per 4 posti: 28)
		• Premium
			§ 20-22 AC DEGH JL (3 file per 8 posti: 24)
		• Economy
			§ 30-43 ABC DEH JKL (14 file per 9 posti: 126) 
			§ 44 AC DEH JL (7)
			§ 45-58 ABC DEH JKL (14 file per 9 posti: 126)
			§ 59 DEH (3)
		• Posti totali a disposizione:  317
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-900NEO';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,1,'A,D,H';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,2,8,'A,D,H,L';
		--Premium
		select @id_fare_family = id from fare_type_families where family_code = 'P';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,20,22,'A,C,D,E,G,H,J,L';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,30,43,'A,B,C,D,E,H,J,K,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,44,44,'A,C,D,E,H,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,45,58,'A,B,C,D,E,H,J,K,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,59,59,'D,E,H';


		--AIRBUS A321NEO
		/*
		• https://www.aerolopa.com/az-32q
		• Business
			§ 1-6 AF 6 - file per 2 posti: 12
		• Premium
			§ 20-22 AC DE - 3 file per 4 posti: 12
		• Economy
			§ 30-52 ABC DEF - 23 file per 4 posti: 92
			§ 53 DEF - 1 file per 3 posti: 3
		• Posti totali a disposizione
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A321NEO';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,6,'A,F';
		--Premium
		select @id_fare_family = id from fare_type_families where family_code = 'P';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,20,22,'A,C,D,E';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,30,52,'A,B,C,D,E,F';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,53,53,'D,E,F';
					
		--AIRBUS A220-300
		/*
		• https://www.aerolopa.com/az-223
		• Business: 1-4 A DF (4 file per 3 posti: 12 totali)
		• Economy 
			§ 5-30 AC DEF (26 file per 5 posti: 130)
			§ 31 DEF (1 file per 3 posti): 3
		• Posti totali a disposizione: 145
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A220-300';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,4,'A,D,F';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,5,30,'A,C,D,E,F';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,5,31,'D,E,F';

		--AIRBUS A320
		/*
		• https://www.aerolopa.com/az-320-2
		• Business 1-9 AC DF - 9 file per 4 posti: 36
		• Economy 10-32 ABC DEF -23 file per 6 posti:  138
		• Posti totali a disposizione: 174 
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A320';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,9,'A,C,D,F';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,10,32,'A,B,C,D,E,F';
		
		--AIRBUS A330-200
		/*
		• https://www.aerolopa.com/az-332
		• Business: 20 posti
			§ 1.3.5 C EG J - 3 file per 4 posti: 12
			§ 2.4 A DH L - 2 file per 4 posti: 8
		• Premium: 17 posti
			§ 8-9 AC DEG JL -  2file per 7 posti: 14
			§ 10 DEG: 1 file per 3 posti: 3
		• Economy: 209 posti
			§ 12 AC JL - 1 fila per 4 posti: 4
			§ 15-16.18-27 AC DEGH JL 12 file per 8 posti: 96
			§ 28 DEGH - 1 file per 4 posti: 4
			§ 29-38 AC DEGH JL 10 file per 8 posti: 80
			§ 39-41 AC DEG JL 3 file per 7 posti: 21
			§ 42 AC JL: 1 fila per 4 posti: 4
		• Posti totali a disposizione: 246
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A330-200';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,1,'C,E,G,J';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,2,2,'A,D,H,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,3,3,'C,E,G,J';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,4,4,'A,D,H,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,5,5,'C,E,G,J';
		--Premium
		select @id_fare_family = id from fare_type_families where family_code = 'P';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,8,9,'A,C,D,E,G,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,10,10,'D,E,G';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,12,12,'A,C,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,15,16,'A,C,D,E,G,H,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,18,27,'A,C,D,E,G,H,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,28,28,'D,E,G,H';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,29,38,'A,C,D,E,G,H,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,39,41,'A,C,D,E,G,J,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,42,42,'J,L';

		--AIRBUS A320NEO
		/*
		• https://www.aerolopa.com/az-32n-2
		• Business 1-9 AC DF - 9 file per 4 posti: 36
		• Economy 10-32 ABC DEF -23 file per 6 posti:  138
		• Posti totali a disposizione: 174 
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A320NEO';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,9,'A,C,D,F';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,10,32,'A,B,C,D,E,F';


		--Configurazioni Air France
		select @id_airline = id from airlines where iata_airline_code = 'AF';
		--AIRBUS A350-900 (AF)
		/*
		• https://www.aerolopa.com/af-359-2
		• Business: 1-8.10-12.14 A D H L: 12 file per 4 posti: 48
		• Premium: 15-18 AB DEGH KL - 4 file per 8 posti: 32
		• Economy: 212 posti
			§ 21-28.30-44 ABC DEH JKL 23 file per 9 posti: 207
			§ 45 AB DEH: 1 fila per 5 posti: 5
		• Posti totali a disposizione: 292
		*/
		select @id_airplane = id from airplanes where model = 'AIRBUS A350-900';
		--Business
		select @id_fare_family = id from fare_type_families where family_code = 'B';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,1,8,'A,D,H,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,10,12,'A,D,H,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane, @id_fare_family,14,14,'A,D,H,L';
		--Premium
		select @id_fare_family = id from fare_type_families where family_code = 'P';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,15,18,'A,B,D,E,G,H,K,L';
		--Economy
		select @id_fare_family = id from fare_type_families where family_code = 'E';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,21,28,'A,B,C,D,E,H,J,K,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,30,44,'A,B,C,D,E,H,J,K,L';
		exec sp_add_seats_configuration @id_airline,@id_airplane ,@id_fare_family,45,45,'A,B,D,E,H';


		select l.airline_name,p.model,f.family_name,s.*
		from airplane_seats s
		inner join airlines l on s.id_airline = l.id
		inner join airplanes p on s.id_airplane = p.id
		inner join fare_type_families f on s.id_fare_type_family = f.id;
		
		end


	commit transaction
	print 'Script eseguito con successo';


end try
begin catch
	rollback transaction

	print ERROR_NUMBER();
	PRINT ERROR_MESSAGE(); 
end catch
