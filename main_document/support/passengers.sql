--CREAZIONE TABELLA passengers
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
  [doc_number] varchar(50) NOT NULL,
  [doc_expiration_date] date NOT NULL
)
GO

--CREAZIONE FOREIGN KEY TABELLA passengers
ALTER TABLE [passengers] ADD CONSTRAINT [reservation_to_reservation_passengers] FOREIGN KEY ([id_reservation]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [passengers] ADD CONSTRAINT [user_to_reservation_passengers] FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [passengers] ADD CONSTRAINT [identity_document_type_to_reservation_passengers] FOREIGN KEY ([id_doc_type]) REFERENCES [identity_document_types] ([id])
GO


