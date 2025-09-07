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
  [country_name] varchar(25) UNIQUE NOT NULL
)
GO

CREATE TABLE [cities] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [country_id] tinyint,
  [area_local_code] varchar(5),
  [city_name] varchar(25) UNIQUE NOT NULL
)
GO

CREATE TABLE [airports] (
  [id] smallint PRIMARY KEY IDENTITY(1, 1),
  [iata_airport_code] char(3) UNIQUE NOT NULL,
  [city_id] smallint NOT NULL,
  [airport_name] varchar(50) UNIQUE,
  [airport_address] varchar(255)
)
GO

CREATE TABLE [price_components] (
  [id] tinyint PRIMARY KEY IDENTITY(1, 1),
  [price_component_code] varchar(3) UNIQUE NOT NULL,
  [price_component_name] varchar(50) NOT NULL,
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

CREATE TABLE [fare_types] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [fare_code] varchar(5) UNIQUE NOT NULL,
  [fare_name] varchar(25) NOT NULL
)
GO

CREATE TABLE [fare_type_options] (
  [id] smallint PRIMARY KEY,
  [option_code] varchar(15) UNIQUE NOT NULL
)
GO

CREATE TABLE [fare_type_details] (
  [id_fare_type] int NOT NULL,
  [id_fare_type_option] smallint NOT NULL,
  PRIMARY KEY ([id_fare_type], [id_fare_type_option])
)
GO

CREATE TABLE [telephone_type] (
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
  [id_flight] smallint NOT NULL,
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
  [birth_date] datetime NOT NULL,
  [id_sex_type] tinyint NOT NULL,
  [email] varchar(100) NOT NULL,
  [id_telephone] bigint NOT NULL,
  [address] varchar(1000) NOT NULL,
  [zip_code] varchar(10),
  [id_city] smallint NOT NULL,
  [frequent_flyer_code] varchar(15),
  [frequent_flyer_exp_date] datetime,
  [freuqent_flyer_point_balance] int
)
GO

CREATE TABLE [airplane_seats] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_airplane] int NOT NULL,
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
  [arrival_time] date NOT NULL
)
GO

CREATE TABLE [reservations] (
  [id] bigint PRIMARY KEY,
  [pnr_code] varchar(6) NOT NULL,
  [id_reservation_system] tinyint NOT NULL,
  [id_origin_airport] smallint NOT NULL,
  [id_destination_airport] smallint NOT NULL,
  [departure_date] datetime NOT NULL,
  [return_date] datetime,
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
  [id] bigint UNIQUE PRIMARY KEY,
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

ALTER TABLE [telephones] ADD CONSTRAINT [telephone_type_to_telephones] FOREIGN KEY ([id_telephone_type]) REFERENCES [telephone_type] ([id])
GO

ALTER TABLE [reservations_telephones] ADD CONSTRAINT [reservation_to_reservations_telephones] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [reservations_telephones] ADD CONSTRAINT [telephone_to_reservations_telephones] FOREIGN KEY ([id_telephone]) REFERENCES [telephones] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [reservation_to_status_reservations] FOREIGN KEY ([id_reservations_status]) REFERENCES [reservations_statuses] ([id])
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
