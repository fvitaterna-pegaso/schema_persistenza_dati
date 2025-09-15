/**********
Nome Script		read_model_simple_objects.sql
Autore			Fabio Vitaterna
Descrizione		Set di query e oggetti per alcuni use case di esempio di un read model semplice basato su SQL
Note			
**********/


/**************PREMNOTAZIONI********************/

use db_abdf0e_fvitapegaso

go

--Header Prenotazione
--QUERY
select	r.id,
		r.pnr_code,
		r.id_reservation_system,
		rSys.reservation_system_code,
		rSys.reservation_system_name,
		r.id_origin_airport,
		orig.iata_airport_code AS origin_iata_airport_code,
		orig.airport_name as origin_airport_name,
		cOrig.city_name as origin_city_name,
		r.id_destination_airport,
		dest.iata_airport_code as destination_iata_airport_code,
		dest.airport_name as detination_airport_name,
		cDest.city_name as detination_city_name,
		r.round_trip,
		case r.round_trip
			when 0 then 'One Way'
			when 1 then 'Round Trip'
		end as tipo_viaggio,
		r.departure_date,
		r.return_date,
		r.id_fare_type,
		fare.fare_code,
		fare.fare_name,
		r.total_price,
		r.discount,
		case r.total_price
			when null then null
			else r.total_price - ISNULL(r.discount,0)
		end as discounted_total_price,
		r.id_payment_method,
		pMeth.cod as payment_method_cod,
		pMeth.method_name,
		r.check_in,
		case r.check_in
			when 0 then 'Chek In is not available'
			when 1 then 'Check In is available'
		end as chek_in_availability,
		r.checked_in,
		case r.checked_in
			when 0 then 'Check In not executed'
			when 1 then 'Check In executed'
		end as check_in_status,
		r.owner_conditions_acceptance,
		r.id_reservations_status,
		rStat.cod as reservation_status_cod,
		rStat.status_name,
		rStat.status_description
from reservations r
inner join reservation_systems rSys on r.id_reservation_system = rSys.id
inner join airports orig on r.id_origin_airport = orig.id
inner join cities cOrig on orig.city_id = cOrig.id
inner join airports dest on r.id_destination_airport = dest.id
inner join cities cDest on dest.city_id = cDest.id
inner join fare_types fare on r.id_fare_type = fare.id
left join payment_methods pMeth on r.id_payment_method = pMeth.id
inner join reservations_statuses rStat on r.id_reservations_status = rStat.id;

go
--VIEW

if exists(select name from sys.views where name = 'v_reservations')
	drop view v_reservations;


go

create view v_reservations as
	select	r.id,
			r.pnr_code,
			r.id_reservation_system,
			rSys.reservation_system_code,
			rSys.reservation_system_name,
			r.id_origin_airport,
			orig.iata_airport_code AS origin_iata_airport_code,
			orig.airport_name as origin_airport_name,
			cOrig.city_name as origin_city_name,
			r.id_destination_airport,
			dest.iata_airport_code as destination_iata_airport_code,
			dest.airport_name as detination_airport_name,
			cDest.city_name as detination_city_name,
			r.round_trip,
			case r.round_trip
				when 0 then 'One Way'
				when 1 then 'Round Trip'
			end as tipo_viaggio,
			r.departure_date,
			r.return_date,
			r.id_fare_type,
			fare.fare_code,
			fare.fare_name,
			r.total_price,
			r.discount,
			case r.total_price
				when null then null
				else r.total_price - ISNULL(r.discount,0)
			end as discounted_total_price,
			r.id_payment_method,
			pMeth.cod as payment_method_cod,
			pMeth.method_name,
			r.check_in,
			case r.check_in
				when 0 then 'Chek In is not available'
				when 1 then 'Check In is available'
			end as chek_in_availability,
			r.checked_in,
			case r.checked_in
				when 0 then 'Check In not executed'
				when 1 then 'Check In executed'
			end as check_in_status,
			r.owner_conditions_acceptance,
			r.id_reservations_status,
			rStat.cod as reservation_status_cod,
			rStat.status_name,
			rStat.status_description
	from reservations r
	inner join reservation_systems rSys on r.id_reservation_system = rSys.id
	inner join airports orig on r.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on r.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join fare_types fare on r.id_fare_type = fare.id
	left join payment_methods pMeth on r.id_payment_method = pMeth.id
	inner join reservations_statuses rStat on r.id_reservations_status = rStat.id;

go
--SP
if exists(select * from sys.procedures where name = 'sp_get_reservation_by_pnr')
	drop procedure sp_get_reservation_by_pnr;

go

create procedure sp_get_reservation_by_pnr
	@pnr_code varchar(6)
as
	select	r.id,
			r.pnr_code,
			r.id_reservation_system,
			rSys.reservation_system_code,
			rSys.reservation_system_name,
			r.id_origin_airport,
			orig.iata_airport_code AS origin_iata_airport_code,
			orig.airport_name as origin_airport_name,
			cOrig.city_name as origin_city_name,
			r.id_destination_airport,
			dest.iata_airport_code as destination_iata_airport_code,
			dest.airport_name as detination_airport_name,
			cDest.city_name as detination_city_name,
			r.round_trip,
			case r.round_trip
				when 0 then 'One Way'
				when 1 then 'Round Trip'
			end as tipo_viaggio,
			r.departure_date,
			r.return_date,
			r.id_fare_type,
			fare.fare_code,
			fare.fare_name,
			r.total_price,
			r.discount,
			case r.total_price
				when null then null
				else r.total_price - ISNULL(r.discount,0)
			end as discounted_total_price,
			r.id_payment_method,
			pMeth.cod as payment_method_cod,
			pMeth.method_name,
			r.check_in,
			case r.check_in
				when 0 then 'Chek In is not available'
				when 1 then 'Check In is available'
			end as chek_in_availability,
			r.checked_in,
			case r.checked_in
				when 0 then 'Check In not executed'
				when 1 then 'Check In executed'
			end as check_in_status,
			r.owner_conditions_acceptance,
			r.id_reservations_status,
			rStat.cod as reservation_status_cod,
			rStat.status_name,
			rStat.status_description
	from reservations r
	inner join reservation_systems rSys on r.id_reservation_system = rSys.id
	inner join airports orig on r.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on r.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join fare_types fare on r.id_fare_type = fare.id
	left join payment_methods pMeth on r.id_payment_method = pMeth.id
	inner join reservations_statuses rStat on r.id_reservations_status = rStat.id
	where r.pnr_code = @pnr_code

	exec sp_get_reservation_by_pnr 'Y8Z0AR'
go

--Tratte della prenotazione
--QUERY

select	j.id_journey
		, j.id_reservation
		, r.pnr_code
		, j.flight_segment_number
		, j.id_flight_schedule
		, fSched.id_flight
		, a.airline_name
		, f.iata_flight_code 
		, orig.iata_airport_code as origin_iata_flight_code
		, cOrig.city_name as origin_city_name
		, dest.iata_airport_code as destination_iata_flight_code
		, cDest.city_name as destnation_city_name
		, pl.model
		, fSched.departure_date
		, fSched.departure_time
		, fSched.arrival_date
		, fSched.arrival_time
from journeys j
inner join reservations r on j.id_reservation = r.id
inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
inner join airports orig on fSched.id_origin_airport = orig.id
inner join cities cOrig on orig.city_id = cOrig.id
inner join airports dest on fSched.id_destination_airport = dest.id
inner join cities cDest on dest.city_id = cDest.id
inner join flights f on fSched.id_flight = f.id
inner join airlines a on f.id_airline = a.id
inner join airplanes pl on fSched.id_airplane = pl.id
order by j.id_reservation,j.flight_segment_number

go
--query

if exists (select name from sys.views where name = 'v_reservations_journeys')
	drop view v_reservations_journeys;

go

create view v_reservations_journeys as
	select	j.id_journey
			, j.id_reservation
			, r.pnr_code
			, j.flight_segment_number
			, j.id_flight_schedule
			, fSched.id_flight
			, a.airline_name
			, f.iata_flight_code 
			, orig.iata_airport_code as origin_iata_flight_code
			, cOrig.city_name as origin_city_name
			, dest.iata_airport_code as destination_iata_flight_code
			, cDest.city_name as destnation_city_name
			, pl.model
			, fSched.departure_date
			, fSched.departure_time
			, fSched.arrival_date
			, fSched.arrival_time
	from journeys j
	inner join reservations r on j.id_reservation = r.id
	inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
	inner join airports orig on fSched.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on fSched.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join flights f on fSched.id_flight = f.id
	inner join airlines a on f.id_airline = a.id
	inner join airplanes pl on fSched.id_airplane = pl.id


go
--sp

if exists(select name from sys.procedures where name = 'sp_get_reservation_journeys_by_pnr')
	drop procedure sp_get_reservation_journeys_by_pnr;

go

create procedure sp_get_reservation_journeys_by_pnr
	@pnr_code varchar(6)
as
	select	j.id_journey
			, j.id_reservation
			, r.pnr_code
			, j.flight_segment_number
			, j.id_flight_schedule
			, fSched.id_flight
			, a.airline_name
			, f.iata_flight_code 
			, orig.iata_airport_code as origin_iata_flight_code
			, cOrig.city_name as origin_city_name
			, dest.iata_airport_code as destination_iata_flight_code
			, cDest.city_name as destnation_city_name
			, pl.model
			, fSched.departure_date
			, fSched.departure_time
			, fSched.arrival_date
			, fSched.arrival_time
	from journeys j
	inner join reservations r on j.id_reservation = r.id
	inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
	inner join airports orig on fSched.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on fSched.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join flights f on fSched.id_flight = f.id
	inner join airlines a on f.id_airline = a.id
	inner join airplanes pl on fSched.id_airplane = pl.id
	where r.pnr_code = @pnr_code
	order by j.flight_segment_number;

	exec sp_get_reservation_journeys_by_pnr 'Y8Z0AR'
go

--Passeggeri
--QUERY

select	p.id
		, p.id_reservation
		, r.pnr_code
		, rStat.status_description as reservation_status
		, p.ticket_number
		, p.first_name
		, p.last_name
		, p.birth_date
		, p.email
		, idt.type_name as id_type
		, p.doc_number as id_number
		, p.doc_expiration_date as id_expiration_date
		, u.frequent_flyer_code
		, u.frequent_flyer_exp_date
		, u.frequent_flyer_point_balance
from passengers p
inner join reservations r on p.id_reservation = r.id
inner join reservations_statuses rStat on r.id_reservations_status = rStat.id
inner join identity_document_types idt on p.id_doc_type = idt.id
left join users u on p.user_id = u.user_id

GO
--view

if exists(select name from sys.views where name = 'v_passengers')
	drop view v_passengers;

GO

create view v_passengers as
	select	p.id
			, p.id_reservation
			, r.pnr_code
			, rStat.status_description as reservation_status
			, p.ticket_number
			, p.first_name
			, p.last_name
			, p.birth_date
			, p.email
			, idt.type_name as id_type
			, p.doc_number as id_number
			, p.doc_expiration_date as id_expiration_date
			, u.frequent_flyer_code
			, u.frequent_flyer_exp_date
			, u.frequent_flyer_point_balance
	from passengers p
	inner join reservations r on p.id_reservation = r.id
	inner join reservations_statuses rStat on r.id_reservations_status = rStat.id
	inner join identity_document_types idt on p.id_doc_type = idt.id
	left join users u on p.user_id = u.user_id;


go
--SP

if exists(select name from sys.procedures where name = 'sp_get_passengers_by_pnr')
	drop procedure sp_get_passengers_by_pnr;

go

create procedure sp_get_passengers_by_pnr
	@pnr_code varchar(6)
as
	select	p.id
			, p.id_reservation
			, r.pnr_code
			, rStat.status_description as reservation_status
			, p.ticket_number
			, p.first_name
			, p.last_name
			, p.birth_date
			, p.email
			, idt.type_name as id_type
			, p.doc_number as id_number
			, p.doc_expiration_date as id_expiration_date
			, u.frequent_flyer_code
			, u.frequent_flyer_exp_date
			, u.frequent_flyer_point_balance
	from passengers p
	inner join reservations r on p.id_reservation = r.id
	inner join reservations_statuses rStat on r.id_reservations_status = rStat.id
	inner join identity_document_types idt on p.id_doc_type = idt.id
	left join users u on p.user_id = u.user_id;

	--exec sp_get_passengers_by_pnr 'Y8Z0AR'
go

--Componenti prezzo per passeggero e per prenotazione
--QUERY
select	comp.id_passenger
		, p.id_reservation
		, comp.id_price_conponent
		, r.pnr_code
		, p.first_name
		, p.last_name
		, compType.price_component_code
		, compType.price_component_name
		, comp.price
from reservation_component_prices comp
inner join passengers p on comp.id_passenger = p.id
inner join reservations r on p.id_reservation = r.id
inner join price_components compType on comp.id_price_conponent = compType.id


go
--view

if exists(select name from sys.views where name = 'v_tickets_components_prices')
	drop view v_tickets_components_prices;

go

create view v_tickets_components_prices as
	select	comp.id_passenger
			, p.id_reservation
			, comp.id_price_conponent
			, r.pnr_code
			, p.first_name
			, p.last_name
			, compType.price_component_code
			, compType.price_component_name
			, comp.price
	from reservation_component_prices comp
	inner join passengers p on comp.id_passenger = p.id
	inner join reservations r on p.id_reservation = r.id
	inner join price_components compType on comp.id_price_conponent = compType.id;


go
--sp

if exists (select name from sys.procedures where name = 'sp_get_ticket_component_by_pnr_passenger')
	drop procedure sp_get_ticket_component_by_pnr_passenger;

go
create procedure sp_get_ticket_component_by_pnr_passenger
	@pnr_code varchar(6),
	@id_passenger bigint
as
	select	comp.id_passenger
			, p.id_reservation
			, comp.id_price_conponent
			, r.pnr_code
			, p.first_name
			, p.last_name
			, compType.price_component_code
			, compType.price_component_name
			, comp.price
	from reservation_component_prices comp
	inner join passengers p on comp.id_passenger = p.id
	inner join reservations r on p.id_reservation = r.id
	inner join price_components compType on comp.id_price_conponent = compType.id
	where r.pnr_code = @pnr_code and comp.id_passenger = @id_passenger;

	exec sp_get_ticket_component_by_pnr_passenger 'Y8Z0AR',4;

go


--Tratta per passeggero
--QUERY
select	j.id_journey
		, j.id_reservation
		, r.pnr_code
		, p.first_name
		, p.last_name
		, j.flight_segment_number
		, j.id_flight_schedule
		, fSched.id_flight
		, a.airline_name
		, f.iata_flight_code 
		, orig.iata_airport_code as origin_iata_flight_code
		, cOrig.city_name as origin_city_name
		, dest.iata_airport_code as destination_iata_flight_code
		, cDest.city_name as destnation_city_name
		, pl.model
		, fSched.departure_date
		, fSched.departure_time
		, fSched.arrival_date
		, fSched.arrival_time
		, airSeats.seat
		, fare.fare_code
		, fare.fare_name
from journeys j
inner join reservations r on j.id_reservation = r.id
inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
inner join airports orig on fSched.id_origin_airport = orig.id
inner join cities cOrig on orig.city_id = cOrig.id
inner join airports dest on fSched.id_destination_airport = dest.id
inner join cities cDest on dest.city_id = cDest.id
inner join flights f on fSched.id_flight = f.id
inner join airlines a on f.id_airline = a.id
inner join airplanes pl on fSched.id_airplane = pl.id
left join flight_schedule_seats seats on seats.id_journey = j.id_journey
left join airplane_seats airSeats on seats.id_seat = airSeats.id
left join passengers p on seats.id_passenger = p.id
inner join fare_types fare on seats.id_fare_type = fare.id
order by j.id_reservation,j.flight_segment_number

GO
--VIEW
if exists(select name from sys.views where name = 'v_passengers_journeys')
	drop view v_passengers_journeys;

GO

create view v_passengers_journeys as
	select	j.id_journey
			, j.id_reservation
			, r.pnr_code
			, p.first_name
			, p.last_name
			, j.flight_segment_number
			, j.id_flight_schedule
			, fSched.id_flight
			, a.airline_name
			, f.iata_flight_code 
			, orig.iata_airport_code as origin_iata_flight_code
			, cOrig.city_name as origin_city_name
			, dest.iata_airport_code as destination_iata_flight_code
			, cDest.city_name as destnation_city_name
			, pl.model
			, fSched.departure_date
			, fSched.departure_time
			, fSched.arrival_date
			, fSched.arrival_time
			, airSeats.seat
			, fare.fare_code
			, fare.fare_name
	from journeys j
	inner join reservations r on j.id_reservation = r.id
	inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
	inner join airports orig on fSched.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on fSched.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join flights f on fSched.id_flight = f.id
	inner join airlines a on f.id_airline = a.id
	inner join airplanes pl on fSched.id_airplane = pl.id
	left join flight_schedule_seats seats on seats.id_journey = j.id_journey
	left join airplane_seats airSeats on seats.id_seat = airSeats.id
	left join passengers p on seats.id_passenger = p.id
	inner join fare_types fare on seats.id_fare_type = fare.id;


GO
--sp
if exists (select name from sys.procedures where name = 'sp_get_get_passenger_journey_by_pnr')
	drop procedure sp_get_get_passenger_journey_by_pnr;

go

create procedure sp_get_get_passenger_journey_by_pnr
	@pnr_code varchar(6),
	@id_passenger bigint
as
	select	j.id_journey
			, j.id_reservation
			, r.pnr_code
			, p.first_name
			, p.last_name
			, j.flight_segment_number
			, j.id_flight_schedule
			, fSched.id_flight
			, a.airline_name
			, f.iata_flight_code 
			, orig.iata_airport_code as origin_iata_flight_code
			, cOrig.city_name as origin_city_name
			, dest.iata_airport_code as destination_iata_flight_code
			, cDest.city_name as destnation_city_name
			, pl.model
			, fSched.departure_date
			, fSched.departure_time
			, fSched.arrival_date
			, fSched.arrival_time
			, airSeats.seat
			, fare.fare_code
			, fare.fare_name
	from journeys j
	inner join reservations r on j.id_reservation = r.id
	inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
	inner join airports orig on fSched.id_origin_airport = orig.id
	inner join cities cOrig on orig.city_id = cOrig.id
	inner join airports dest on fSched.id_destination_airport = dest.id
	inner join cities cDest on dest.city_id = cDest.id
	inner join flights f on fSched.id_flight = f.id
	inner join airlines a on f.id_airline = a.id
	inner join airplanes pl on fSched.id_airplane = pl.id
	left join flight_schedule_seats seats on seats.id_journey = j.id_journey
	left join airplane_seats airSeats on seats.id_seat = airSeats.id
	left join passengers p on seats.id_passenger = p.id
	inner join fare_types fare on seats.id_fare_type = fare.id
	where r.pnr_code = @pnr_code and p.id = @id_passenger
	order by j.flight_segment_number;

	exec sp_get_get_passenger_journey_by_pnr 'Y8Z0AR',3
go

