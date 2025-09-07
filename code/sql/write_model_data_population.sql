/**********
Nome Script		write_model_data_population.sql
Autore			Fabio Vitaterna
Descrizione		Popolamento dei dati di test del modello
Note			Se il modello già esiste, è opportuno ricrearlo tramite lo script write_model.sql per evitare duplicazioni di dati
**********/

use db_abdf0e_fvitapegaso

go

--1. Tabella sex_types
--insert into sex_types (cod,sex_type_name)
--	values('F', 'Sesso Femminile');

--insert into sex_types (cod,sex_type_name)
--	values('M', 'Sesso Maschile');

--insert into sex_types (cod,sex_type_name)
--	values('U', 'Non voglio dichiarare il mio sesso');

--select * from sex_types;

GO

--2, Tabella continents
--insert into continents (cod, continent_name) values ('AF', 'Africa');
--insert into continents (cod, continent_name) values ('AS', 'Asia');
--insert into continents (cod, continent_name) values ('EU', 'Europa');
--insert into continents (cod, continent_name) values ('NA', 'America del Nord');
--insert into continents (cod, continent_name) values ('SA', 'America del Sud');
--insert into continents (cod, continent_name) values ('OC', 'Oceania');

--select * from continents

GO
