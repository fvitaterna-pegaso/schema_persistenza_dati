--CREAZIONE TABELLA journeys
CREATE TABLE [journeys] (
  [id_journey] bigint PRIMARY KEY IDENTITY(1, 1),
  [id_reservation] bigint NOT NULL,
  [id_flight_schedule] bigint NOT NULL,
  [flight_segment_number] tinyint NOT NULL
)
GO

--CREAZIONE FOREIGN KEYS TABELLA journeys
ALTER TABLE [journeys] ADD CONSTRAINT [reservation_to_journeys] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [journeys] ADD CONSTRAINT [flight_schedule_to_journeys] FOREIGN KEY ([id_flight_schedule]) REFERENCES [flight_schedules] ([id])
GO

