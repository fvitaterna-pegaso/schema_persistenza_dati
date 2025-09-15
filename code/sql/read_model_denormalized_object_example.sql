/**********
Nome Script		read_model_denormalized_object_example.sql
Autore			Fabio Vitaterna
Descrizione		Creazione di un tabella denormalizzata basata sull'header Prenotazioni
Note			
**********/


USE [db_abdf0e_fvitapegaso]
GO

if exists
(
	SELECT t.object_id
	FROM sys.tables t
	INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
	WHERE t.name = 'reservations_data' and s.name = 'read_model'
)
	drop table read_model.reservations_data;

GO

/****** Object:  Table [read_model].[reservations_data]    Script Date: 15/09/2025 22:50:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [read_model].[reservations_data](
	[id] [bigint] NOT NULL primary key,
	[pnr_code] [varchar](6) NULL,
	[id_reservation_system] [tinyint] NULL,
	[reservation_system_code] [varchar](3) NULL,
	[reservation_system_name] [varchar](25) NULL,
	[id_origin_airport] [smallint] NULL,
	[origin_iata_airport_code] [char](3) NULL,
	[origin_airport_name] [varchar](50) NULL,
	[origin_city_name] [varchar](25) NULL,
	[id_destination_airport] [smallint] NULL,
	[destination_iata_airport_code] [char](3) NULL,
	[detination_airport_name] [varchar](50) NULL,
	[detination_city_name] [varchar](25) NULL,
	[round_trip] [bit] NULL,
	[tipo_viaggio] [varchar](10) NULL,
	[departure_date] [date] NULL,
	[return_date] [date] NULL,
	[id_fare_type] [int] NULL,
	[fare_code] [varchar](5) NULL,
	[fare_name] [varchar](25) NULL,
	[total_price] [money] NULL,
	[discount] [money] NULL,
	[discounted_total_price] [money] NULL,
	[id_payment_method] [tinyint] NULL,
	[payment_method_cod] [varchar](10) NULL,
	[method_name] [varchar](50) NULL,
	[check_in] [bit] NULL,
	[chek_in_availability] [varchar](24) NULL,
	[checked_in] [bit] NULL,
	[check_in_status] [varchar](21) NULL,
	[owner_conditions_acceptance] [bit] NULL,
	[id_reservations_status] [tinyint] NULL,
	[reservation_status_cod] [varchar](7) NULL,
	[status_name] [varchar](15) NULL,
	[status_description] [varchar](100) NULL
) ON [PRIMARY]
GO

insert into read_model.reservations_data
select * from v_reservations;

