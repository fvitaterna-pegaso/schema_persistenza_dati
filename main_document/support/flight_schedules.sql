--CREAZIONE TABELLA flight_schedules
CREATE TABLE [flight_schedules] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_flight] smallint NOT NULL,
  [id_airplane] int NOT NULL,
  [id_origin_airport] smallint NOT NULL,
  [id_destination_airport] smallint NOT NULL,
  [departure_date] date NOT NULL,
  [departure_time] time NOT NULL,
  [arrival_date] date NOT NULL,
  [arrival_time] time NOT NULL
)
GO

--CREAZIONE INDICE UNIVOCO SUI CAMPI id_flight E departure_date DELLA TABELLA flight_schedules
CREATE UNIQUE INDEX [flight_schedules_index_0] ON [flight_schedules] ("id_flight", "departure_date")
GO

--CREAZIONE FOREIGN KEYS DELLA TABELLA flight_schedules
ALTER TABLE [flight_schedules] ADD CONSTRAINT [flight_to_flight_schedules] FOREIGN KEY ([id_flight]) REFERENCES [flights] ([id])
GO

ALTER TABLE [flight_schedules] ADD CONSTRAINT [airplanes_to_flight_schedules] FOREIGN KEY ([id_airplane]) REFERENCES [airplanes] ([id])
GO

ALTER TABLE [flight_schedules] ADD CONSTRAINT [origin_airport_to_flight_schedules] FOREIGN KEY ([id_origin_airport]) REFERENCES [airports] ([id])
GO

ALTER TABLE [flight_schedules] ADD CONSTRAINT [destination_airport_to_flight_schedules] FOREIGN KEY ([id_destination_airport]) REFERENCES [airports] ([id])
GO

