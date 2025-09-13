/**********
Nome Script		write_model.sql
Autore			Fabio Vitaterna
Descrizione		Creazione del modello di persistanza da zero
Note			Se il modello già esiste, prima di ricrearlo, lo script lo elimina completamente (dati inclusi)
**********/

use db_abdf0e_fvitapegaso

go

/**********CHECK ESISTENZA FK********************/

if exists(select name from sys.foreign_keys where name = 'continent_to_countries')
		and exists(select * from sys.tables where name = 'countries')
	alter table countries drop constraint continent_to_countries 


GO


if exists(select name from sys.foreign_keys where name = 'country_to_cities')
		and exists(select * from sys.tables where name = 'cities')
	alter table cities drop constraint country_to_cities 

GO

if exists(select name from sys.foreign_keys where name = 'city_to_airports')
		and exists(select * from sys.tables where name = 'airports')
	alter table airports drop constraint city_to_airports 

GO

if exists(select name from sys.foreign_keys where name = 'country_to_airline')
		and exists(select * from sys.tables where name = 'airlines')
	alter table [airlines] drop constraint [country_to_airline] 

GO

if exists(select name from sys.foreign_keys where name = 'reservation_to_system_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [reservation_to_system_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'origin_airport_to_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [origin_airport_to_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'origin_destination_to_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [origin_destination_to_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'airline_to_fare_types')
		and exists(select * from sys.tables where name = 'fare_types')
	alter table [fare_types] drop constraint [airline_to_fare_types] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_to_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [fare_type_to_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_to_details')
		and exists(select * from sys.tables where name = 'fare_type_details')
	alter table [fare_type_details] drop constraint [fare_type_to_details] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_options_to_details')
		and exists(select * from sys.tables where name = 'fare_type_details')
	alter table [fare_type_details] drop constraint [fare_type_options_to_details] 

GO

if exists(select name from sys.foreign_keys where name = 'telephone_type_to_telephones')
		and exists(select * from sys.tables where name = 'telephones')
	alter table [telephones] drop constraint [telephone_type_to_telephones] 

GO

if exists(select name from sys.foreign_keys where name = 'reservation_to_reservations_telephones')
		and exists(select * from sys.tables where name = 'reservations_telephones')
	alter table [reservations_telephones] drop constraint [reservation_to_reservations_telephones] 

GO

if exists(select name from sys.foreign_keys where name = 'telephone_to_reservations_telephones')
		and exists(select * from sys.tables where name = 'reservations_telephones')
	alter table [reservations_telephones] drop constraint [telephone_to_reservations_telephones] 

GO

if exists(select name from sys.foreign_keys where name = 'reservation_to_status_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [reservation_to_status_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'airline_to_flights')
		and exists(select * from sys.tables where name = 'flights')
	alter table [flights] drop constraint [airline_to_flights] 

GO

if exists(select name from sys.foreign_keys where name = 'flight_to_flight_schedules')
		and exists(select * from sys.tables where name = 'flight_schedules')
	alter table [flight_schedules] drop constraint [flight_to_flight_schedules] 

GO

if exists(select name from sys.foreign_keys where name = 'airplanes_to_flight_schedules')
		and exists(select * from sys.tables where name = 'flight_schedules')
	alter table [flight_schedules] drop constraint [airplanes_to_flight_schedules] 

GO

if exists(select name from sys.foreign_keys where name = 'airplanes_to_airplans_seats')
		and exists(select * from sys.tables where name = 'airplane_seats')
	alter table [airplane_seats] drop constraint [airplanes_to_airplans_seats] 

GO

if exists(select name from sys.foreign_keys where name = 'journey_to_flight_schedule_seat')
		and exists(select * from sys.tables where name = 'flight_schedule_seats')
	alter table [flight_schedule_seats] drop constraint [journey_to_flight_schedule_seat] 

GO

if exists(select name from sys.foreign_keys where name = 'passenger_to_flight_schedule_seats')
		and exists(select * from sys.tables where name = 'flight_schedule_seats')
	alter table [flight_schedule_seats] drop constraint [passenger_to_flight_schedule_seats] 

GO

if exists(select name from sys.foreign_keys where name = 'seat_to_flight_schedule_seats')
		and exists(select * from sys.tables where name = 'flight_schedule_seats')
	alter table [flight_schedule_seats] drop constraint [seat_to_flight_schedule_seats] 

GO

if exists(select name from sys.foreign_keys where name = 'reservation_to_reservation_passengers')
		and exists(select * from sys.tables where name = 'passengers')
	alter table [passengers] drop constraint [reservation_to_reservation_passengers] 

GO

if exists(select name from sys.foreign_keys where name = 'user_to_reservation_passengers')
		and exists(select * from sys.tables where name = 'passengers')
	alter table [passengers] drop constraint [user_to_reservation_passengers] 

GO

if exists(select name from sys.foreign_keys where name = 'identity_document_type_to_reservation_passengers')
		and exists(select * from sys.tables where name = 'passengers')
	alter table [passengers] drop constraint [identity_document_type_to_reservation_passengers] 

GO

if exists(select name from sys.foreign_keys where name = 'reservation_to_journeys')
		and exists(select * from sys.tables where name = 'journeys')
	alter table [journeys] drop constraint [reservation_to_journeys] 

GO

if exists(select name from sys.foreign_keys where name = 'flight_schedule_to_journeys')
		and exists(select * from sys.tables where name = 'journeys')
	alter table [journeys] drop constraint [flight_schedule_to_journeys] 

GO

if exists(select name from sys.foreign_keys where name = 'passenger_to_reservation_component_price')
		and exists(select * from sys.tables where name = 'reservation_component_prices')
	alter table [reservation_component_prices] drop constraint [passenger_to_reservation_component_price] 

GO

if exists(select name from sys.foreign_keys where name = 'price_component_to_reservation_component_price')
		and exists(select * from sys.tables where name = 'reservation_component_prices')
	alter table [reservation_component_prices] drop constraint [price_component_to_reservation_component_price] 

GO

if exists(select name from sys.foreign_keys where name = 'payment_method_to_reservations')
		and exists(select * from sys.tables where name = 'reservations')
	alter table [reservations] drop constraint [payment_method_to_reservations] 

GO

if exists(select name from sys.foreign_keys where name = 'sex_type_to_users')
		and exists(select * from sys.tables where name = 'users')
	alter table [users] drop constraint [sex_type_to_users] 

GO

if exists(select name from sys.foreign_keys where name = 'telephone_to_users')
		and exists(select * from sys.tables where name = 'users')
	alter table [users] drop constraint [telephone_to_users] 

GO

if exists(select name from sys.foreign_keys where name = 'city_to_users')
		and exists(select * from sys.tables where name = 'users')
	alter table [users] drop constraint [city_to_users] 

GO

if exists(select name from sys.foreign_keys where name = 'flight_schedule_to_base_prices')
		and exists(select * from sys.tables where name = 'flight_schedule_base_prices')
	alter table [flight_schedule_base_prices] drop constraint [flight_schedule_to_base_prices] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_to_base_prices')
		and exists(select * from sys.tables where name = 'flight_schedule_base_prices')
	alter table [flight_schedule_base_prices] drop constraint [fare_type_to_base_prices] 

GO

if exists(select name from sys.foreign_keys where name = 'airline_to_price_components')
		and exists(select * from sys.tables where name = 'price_components')
	alter table [price_components] drop constraint [airline_to_price_components] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_family_to_fare_types')
		and exists(select * from sys.tables where name = 'fare_types')
	alter table [fare_types] drop constraint [fare_type_family_to_fare_types] 

GO

if exists(select name from sys.foreign_keys where name = 'airline_to_airplane_seats')
		and exists(select * from sys.tables where name = 'airplane_seats')
	alter table [airplane_seats] drop constraint [airline_to_airplane_seats] 

GO

if exists(select name from sys.foreign_keys where name = 'fare_type_family_to_airplane_seats')
		and exists(select * from sys.tables where name = 'airplane_seats')
	alter table [airplane_seats] drop constraint [fare_type_family_to_airplane_seats] 

GO
/**********CHECK ESISTENZA TABELLE********************/

/****** Object:  Table [dbo].[airlines]    Script Date: 07/09/2025 17:42:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[airlines]') AND type in (N'U'))
DROP TABLE [dbo].[airlines]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[airplane_seats]    Script Date: 07/09/2025 17:42:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[airplane_seats]') AND type in (N'U'))
DROP TABLE [dbo].[airplane_seats]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[airplanes]    Script Date: 07/09/2025 17:42:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[airplanes]') AND type in (N'U'))
DROP TABLE [dbo].[airplanes]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[airports]    Script Date: 07/09/2025 17:42:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[airports]') AND type in (N'U'))
DROP TABLE [dbo].[airports]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[cities]    Script Date: 07/09/2025 17:42:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cities]') AND type in (N'U'))
DROP TABLE [dbo].[cities]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[continents]    Script Date: 07/09/2025 17:42:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[continents]') AND type in (N'U'))
DROP TABLE [dbo].[continents]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[countries]    Script Date: 07/09/2025 17:42:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[countries]') AND type in (N'U'))
DROP TABLE [dbo].[countries]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[fare_type_details]    Script Date: 07/09/2025 17:42:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fare_type_details]') AND type in (N'U'))
DROP TABLE [dbo].[fare_type_details]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[fare_type_options]    Script Date: 07/09/2025 17:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fare_type_options]') AND type in (N'U'))
DROP TABLE [dbo].[fare_type_options]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[fare_types]    Script Date: 07/09/2025 17:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fare_types]') AND type in (N'U'))
DROP TABLE [dbo].[fare_types]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[flight_schedule_seats]    Script Date: 07/09/2025 17:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[flight_schedule_seats]') AND type in (N'U'))
DROP TABLE [dbo].[flight_schedule_seats]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[flight_schedules]    Script Date: 07/09/2025 17:42:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[flight_schedules]') AND type in (N'U'))
DROP TABLE [dbo].[flight_schedules]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[flights]    Script Date: 07/09/2025 17:42:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[flights]') AND type in (N'U'))
DROP TABLE [dbo].[flights]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[identity_document_types]    Script Date: 07/09/2025 17:42:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[identity_document_types]') AND type in (N'U'))
DROP TABLE [dbo].[identity_document_types]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[journeys]    Script Date: 07/09/2025 17:42:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[journeys]') AND type in (N'U'))
DROP TABLE [dbo].[journeys]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[passengers]    Script Date: 07/09/2025 17:42:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[passengers]') AND type in (N'U'))
DROP TABLE [dbo].[passengers]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[payment_methods]    Script Date: 07/09/2025 17:42:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[payment_methods]') AND type in (N'U'))
DROP TABLE [dbo].[payment_methods]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[price_components]    Script Date: 07/09/2025 17:42:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[price_components]') AND type in (N'U'))
DROP TABLE [dbo].[price_components]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[reservation_component_prices]    Script Date: 07/09/2025 17:42:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reservation_component_prices]') AND type in (N'U'))
DROP TABLE [dbo].[reservation_component_prices]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[reservation_systems]    Script Date: 07/09/2025 17:42:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reservation_systems]') AND type in (N'U'))
DROP TABLE [dbo].[reservation_systems]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[reservations]    Script Date: 07/09/2025 17:42:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reservations]') AND type in (N'U'))
DROP TABLE [dbo].[reservations]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[reservations_statuses]    Script Date: 07/09/2025 17:42:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reservations_statuses]') AND type in (N'U'))
DROP TABLE [dbo].[reservations_statuses]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[reservations_telephones]    Script Date: 07/09/2025 17:42:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reservations_telephones]') AND type in (N'U'))
DROP TABLE [dbo].[reservations_telephones]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[sex_types]    Script Date: 07/09/2025 17:42:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sex_types]') AND type in (N'U'))
DROP TABLE [dbo].[sex_types]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[telephone_types]    Script Date: 07/09/2025 17:42:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[telephone_types]') AND type in (N'U'))
DROP TABLE [dbo].[telephone_types]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[telephones]    Script Date: 07/09/2025 17:42:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[telephones]') AND type in (N'U'))
DROP TABLE [dbo].[telephones]
GO
USE [db_abdf0e_fvitapegaso]
GO
/****** Object:  Table [dbo].[users]    Script Date: 07/09/2025 17:42:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
DROP TABLE [dbo].[users]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[flight_schedule_base_prices]') AND type in (N'U'))
DROP TABLE [dbo].[flight_schedule_base_prices]
GO

--fare_type_families
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fare_type_families]') AND type in (N'U'))
DROP TABLE [dbo].[fare_type_families]
GO

/**********CREAZIONE TABELLE********************/

CREATE TABLE [sex_types] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] char(1) NOT NULL,
  [sex_type_name] varchar(100) NOT NULL
)
GO

CREATE TABLE [continents] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] char(2) UNIQUE NOT NULL,
  [continent_name] varchar(16) NOT NULL
)
GO

CREATE TABLE [countries] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] char(3) UNIQUE NOT NULL,
  [continent_id] tinyint NOT NULL,
  [country_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [cities] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [country_id] tinyint,
  [area_local_code] varchar(5),
  [city_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [airports] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [iata_airport_code] char(3) UNIQUE NOT NULL,
  [city_id] smallint NOT NULL,
  [airport_name] varchar(50) not null,
  [airport_address] varchar(255)
)
GO

CREATE TABLE [price_components] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [id_airline] smallint NOT NULL,
  [price_component_code] varchar(10) NOT NULL,
  [price_component_name] varchar(255) NOT NULL,
  [price_component_regex] varchar(1025)
)
GO

CREATE TABLE [airlines] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [iata_airline_code] char(2) UNIQUE NOT NULL,
  [icao_airline_code] char(3) UNIQUE NOT NULL,
  [airline_name] varchar(50) NOT NULL,
  [id_country] tinyint NOT NULL
)
GO

CREATE TABLE [flights] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [id_airline] smallint NOT NULL,
  [iata_flight_code] varchar(6) UNIQUE NOT NULL
)
GO

CREATE TABLE [reservation_systems] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [reservation_system_code] varchar(3) UNIQUE NOT NULL,
  [reservation_system_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [fare_type_families] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [family_code] char(1) NOT NULL,
  [family_name] varchar(10) NOT NULL
)
GO

CREATE TABLE [fare_types] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_fare_type_family] tinyint NOT NULL,
  [id_airline] smallint NOT NULL,
  [fare_code] varchar(5) NOT NULL,
  [fare_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [fare_type_options] (
  [id] smallint PRIMARY KEY IDENTITY(1,1),
  [option_code] varchar(25) UNIQUE NOT NULL
)
GO

CREATE TABLE [fare_type_details] (
  [id_fare_type] int NOT NULL,
  [id_fare_type_option] smallint NOT NULL,
  [detail_value] varchar(255) NOT NULL,
  PRIMARY KEY ([id_fare_type], [id_fare_type_option])
)
GO

CREATE TABLE [telephone_types] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] varchar(5) UNIQUE NOT NULL,
  [type_name] varchar(50) NOT NULL
)
GO

CREATE TABLE [identity_document_types] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] char(2) NOT NULL,
  [type_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [airplanes] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  --[id_flight] smallint NOT NULL,
  [model] varchar(50) NOT NULL
)
GO

CREATE TABLE [payment_methods] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] varchar(10) NOT NULL,
  [method_name] varchar(50) NOT NULL
)
GO

CREATE TABLE [users] (
  [user_id] uniqueidentifier PRIMARY KEY DEFAULT (NEWID()),
  [user_name] varchar(255) UNIQUE NOT NULL,
  [password] varchar(2048) NOT NULL,
  [first_name] varchar(100) NOT NULL,
  [last_name] varchar(100) NOT NULL,
  [birth_date] date NOT NULL,
  [id_sex_type] tinyint NOT NULL,
  [email] varchar(100) NOT NULL,
  [id_telephone] bigint NOT NULL,
  [address] varchar(1000) NOT NULL,
  [zip_code] varchar(10),
  [id_city] smallint NOT NULL,
  [frequent_flyer_code] varchar(15),
  [frequent_flyer_exp_date] date,
  [frequent_flyer_point_balance] int
)
GO

CREATE TABLE [airplane_seats] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_airplane] int NOT NULL,
  [id_airline] smallint NOT NULL,
  [id_fare_type_family] tinyint NOT NULL,
  [seat] varchar(4)
)
GO

CREATE TABLE [flight_schedules] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_flight] smallint NOT NULL,
  [id_airplane] int NOT NULL,
  [departure_date] date NOT NULL,
  [departure_time] time NOT NULL,
  [arrival_date] date NOT NULL,
  [arrival_time] time NOT NULL
)
GO

CREATE TABLE [flight_schedule_base_prices] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_flight_schedule] bigint NOT NULL,
  [id_fare_type] int NOT NULL,
  [base_price] money NOT NULL
)
GO


CREATE TABLE [reservations] (
  [id] bigint PRIMARY KEY,
  [pnr_code] varchar(6) NOT NULL,
  [id_reservation_system] tinyint NOT NULL,
  [id_origin_airport] smallint NOT NULL,
  [id_destination_airport] smallint NOT NULL,
  [departure_date] date NOT NULL,
  [return_date] date,
  [id_fare_type] int NOT NULL,
  [total_price] money,
  [discount] money,
  [id_payment_method] tinyint,
  [owner_conditions_acceptance] bit NOT NULL,
  [id_reservations_status] tinyint NOT NULL
)
GO

CREATE TABLE [journeys] (
  [id_journey] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_reservation] bigint NOT NULL,
  [id_flight_schedule] bigint NOT NULL,
  [flight_segment_number] tinyint NOT NULL
)
GO

CREATE TABLE [passengers] (
  [id] bigint PRIMARY KEY IDENTiTY(1, 1),
  [id_reservation] bigint NOT NULL,
  [reservation_owner] bit NOT NULL,
  [user_id] uniqueidentifier,
  [ticket_number] varchar(13),
  [first_name] varchar(100) NOT NULL,
  [last_name] varchar(100) NOT NULL,
  [birth_date] date NOT NULL,
  [email] varchar(100),
  [id_doc_type] tinyint NOT NULL,
  [id_doc_number] varchar(50) NOT NULL,
  [id_doc_expiration_date] date NOT NULL
)
GO

CREATE TABLE [reservation_component_prices] (
  [id_passenger] bigint NOT NULL,
  [id_price_conponent] tinyint NOT NULL,
  [price] money NOT NULL,
  PRIMARY KEY ([id_passenger], [id_price_conponent])
)
GO

CREATE TABLE [flight_schedule_seats] (
  [id_journey] bigint NOT NULL,
  [id_passenger] bigint NOT NULL,
  [id_seat] bigint NOT NULL,
  [id_fare_type] int NOT NULL,
  PRIMARY KEY ([id_journey], [id_passenger], [id_seat])
)
GO

CREATE TABLE [reservations_telephones] (
  [id_reservation] bigint NOT NULL,
  [id_telephone] bigint NOT NULL,
  PRIMARY KEY ([id_reservation], [id_telephone])
)
GO

CREATE TABLE [reservations_statuses] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [cod] varchar(7) UNIQUE NOT NULL,
  [status_name] varchar(15) NOT NULL,
  [status_description] varchar(100)
)
GO

CREATE TABLE [telephones] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_telephone_type] tinyint NOT NULL,
  [telephone_country_code] varchar(4) NOT NULL,
  [telephone_area_code] varchar(5) NOT NULL,
  [telephone_number] varchar(10) NOT NULL
)
GO

/**********CREAZIONE  KEYS, CONSTRAINT, ETC********************/

CREATE UNIQUE INDEX [price_components_index_0] ON [price_components] ("id_airline", "price_component_code")

GO

CREATE UNIQUE INDEX [fare_types_index_0] ON [fare_types] ("id_airline", "fare_code")

GO

CREATE UNIQUE INDEX [flight_schedules_index_0] ON [flight_schedules] ("id_flight", "departure_date")
GO

CREATE UNIQUE INDEX [reservations_index_1] ON [reservations] ("id_reservation_system", "pnr_code")
GO

ALTER TABLE [countries] ADD CONSTRAINT [continent_to_countries] FOREIGN KEY ([continent_id]) REFERENCES [continents] ([id])
GO

ALTER TABLE [cities] ADD CONSTRAINT [country_to_cities] FOREIGN KEY ([country_id]) REFERENCES [countries] ([id])
GO

ALTER TABLE [airports] ADD CONSTRAINT [city_to_airports] FOREIGN KEY ([city_id]) REFERENCES [cities] ([id])
GO

ALTER TABLE [airlines] ADD CONSTRAINT [country_to_airline] FOREIGN KEY ([id_country]) REFERENCES [countries] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [reservation_to_system_reservations] FOREIGN KEY ([id_reservation_system]) REFERENCES [reservation_systems] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [origin_airport_to_reservations] FOREIGN KEY ([id_origin_airport]) REFERENCES [airports] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [origin_destination_to_reservations] FOREIGN KEY ([id_destination_airport]) REFERENCES [airports] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [fare_type_to_reservations] FOREIGN KEY ([id_fare_type]) REFERENCES [fare_types] ([id])
GO

ALTER TABLE [fare_type_details] ADD CONSTRAINT [fare_type_to_details] FOREIGN KEY ([id_fare_type]) REFERENCES [fare_types] ([id])
GO

ALTER TABLE [fare_type_details] ADD CONSTRAINT [fare_type_options_to_details] FOREIGN KEY ([id_fare_type_option]) REFERENCES [fare_type_options] ([id])
GO

ALTER TABLE [telephones] ADD CONSTRAINT [telephone_type_to_telephones] FOREIGN KEY ([id_telephone_type]) REFERENCES [telephone_types] ([id])
GO

ALTER TABLE [reservations_telephones] ADD CONSTRAINT [reservation_to_reservations_telephones] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [reservations_telephones] ADD CONSTRAINT [telephone_to_reservations_telephones] FOREIGN KEY ([id_telephone]) REFERENCES [telephones] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [reservation_to_status_reservations] FOREIGN KEY ([id_reservations_status]) REFERENCES [reservations_statuses] ([id])
GO

ALTER TABLE [fare_types] ADD CONSTRAINT [airline_to_fare_types] FOREIGN KEY ([id_airline]) REFERENCES [airlines] ([id])
GO

ALTER TABLE [flights] ADD CONSTRAINT [airline_to_flights] FOREIGN KEY ([id_airline]) REFERENCES [airlines] ([id])
GO

ALTER TABLE [flight_schedules] ADD CONSTRAINT [flight_to_flight_schedules] FOREIGN KEY ([id_flight]) REFERENCES [flights] ([id])
GO

ALTER TABLE [flight_schedules] ADD CONSTRAINT [airplanes_to_flight_schedules] FOREIGN KEY ([id_airplane]) REFERENCES [airplanes] ([id])
GO

ALTER TABLE [airplane_seats] ADD CONSTRAINT [airplanes_to_airplans_seats] FOREIGN KEY ([id_airplane]) REFERENCES [airplanes] ([id])
GO

ALTER TABLE [flight_schedule_seats] ADD CONSTRAINT [journey_to_flight_schedule_seat] FOREIGN KEY ([id_journey]) REFERENCES [journeys] ([id_journey])
GO

ALTER TABLE [flight_schedule_seats] ADD CONSTRAINT [passenger_to_flight_schedule_seats] FOREIGN KEY ([id_passenger]) REFERENCES [passengers] ([id])
GO

ALTER TABLE [flight_schedule_seats] ADD CONSTRAINT [seat_to_flight_schedule_seats] FOREIGN KEY ([id_seat]) REFERENCES [airplane_seats] ([id])
GO

ALTER TABLE [passengers] ADD CONSTRAINT [reservation_to_reservation_passengers] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [passengers] ADD CONSTRAINT [user_to_reservation_passengers] FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [passengers] ADD CONSTRAINT [identity_document_type_to_reservation_passengers] FOREIGN KEY ([id_doc_type]) REFERENCES [identity_document_types] ([id])
GO

ALTER TABLE [journeys] ADD CONSTRAINT [reservation_to_journeys] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [journeys] ADD CONSTRAINT [flight_schedule_to_journeys] FOREIGN KEY ([id_flight_schedule]) REFERENCES [flight_schedules] ([id])
GO

ALTER TABLE [reservation_component_prices] ADD CONSTRAINT [passenger_to_reservation_component_price] FOREIGN KEY ([id_passenger]) REFERENCES [passengers] ([id])
GO

ALTER TABLE [reservation_component_prices] ADD CONSTRAINT [price_component_to_reservation_component_price] FOREIGN KEY ([id_price_conponent]) REFERENCES [price_components] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [payment_method_to_reservations] FOREIGN KEY ([id_payment_method]) REFERENCES [payment_methods] ([id])
GO

ALTER TABLE [users] ADD CONSTRAINT [sex_type_to_users] FOREIGN KEY ([id_sex_type]) REFERENCES [sex_types] ([id])
GO

ALTER TABLE [users] ADD CONSTRAINT [telephone_to_users] FOREIGN KEY ([id_telephone]) REFERENCES [telephones] ([id])
GO

ALTER TABLE [users] ADD CONSTRAINT [city_to_users] FOREIGN KEY ([id_city]) REFERENCES [cities] ([id])
GO

ALTER TABLE [flight_schedule_base_prices] ADD CONSTRAINT [flight_schedule_to_base_prices] FOREIGN KEY ([id_flight_schedule]) REFERENCES [flight_schedules] ([id])
GO

ALTER TABLE [flight_schedule_base_prices] ADD CONSTRAINT [fare_type_to_base_prices] FOREIGN KEY ([id_fare_type]) REFERENCES [fare_types] ([id])
GO

ALTER TABLE [price_components] ADD CONSTRAINT [airline_to_price_components] FOREIGN KEY ([id_airline]) REFERENCES [airlines] ([id])
GO

ALTER TABLE [fare_types] ADD CONSTRAINT [fare_type_family_to_fare_types] FOREIGN KEY ([id_fare_type_family]) REFERENCES [fare_type_families] ([id])
GO

ALTER TABLE [airplane_seats] ADD CONSTRAINT [airline_to_airplane_seats] FOREIGN KEY ([id_airline]) REFERENCES [airlines] ([id])
GO

ALTER TABLE [airplane_seats] ADD CONSTRAINT [fare_type_family_to_airplane_seats] FOREIGN KEY ([id_fare_type_family]) REFERENCES [fare_type_families] ([id])
GO

