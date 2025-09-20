--CREAZIONE TABELLE reservations
CREATE TABLE [reservations] (
  [id] bigint PRIMARY KEY IDENTITY(1,1),
  [pnr_code] varchar(6) NOT NULL,
  [id_reservation_system] tinyint NOT NULL,
  [id_origin_airport] smallint NOT NULL,
  [id_destination_airport] smallint NOT NULL,
  [round_trip] bit not null,
  [departure_date] date NOT NULL,
  [return_date] date,
  [id_fare_type] int NOT NULL,
  [total_price] money,
  [discount] money,
  [id_payment_method] tinyint,
  [check_in] bit NOT NULL DEFAULT (0),
  [checked_in] bit NOT NULL DEFAULT (0),
  [owner_conditions_acceptance] bit NOT NULL,
  [id_reservations_status] tinyint NOT NULL
)
GO

--CREAZIONE INDICE UNIQUE SUI CAMPI id_reservation_system e pnr_code di reservations
CREATE UNIQUE INDEX [reservations_index_1] ON [reservations] ("id_reservation_system", "pnr_code")

GO

--CREAZIONE FOREIGN KEY DELLA TABELLA reservations
ALTER TABLE [reservations] ADD CONSTRAINT [reservation_to_system_reservations] FOREIGN KEY ([id_reservation_system]) REFERENCES [reservation_systems] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [origin_airport_to_reservations] FOREIGN KEY ([id_origin_airport]) REFERENCES [airports] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [origin_destination_to_reservations] FOREIGN KEY ([id_destination_airport]) REFERENCES [airports] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [fare_type_to_reservations] FOREIGN KEY ([id_fare_type]) REFERENCES [fare_types] ([id])
GO

ALTER TABLE [reservations] ADD CONSTRAINT [payment_method_to_reservations] FOREIGN KEY ([id_payment_method]) REFERENCES [payment_methods] ([id])
GO
