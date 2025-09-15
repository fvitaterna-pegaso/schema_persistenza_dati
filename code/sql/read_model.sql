/**********
Nome Script		read_model.sql
Autore			Fabio Vitaterna
Descrizione		Query e Oggett per use di esempio per il read model
Note			
**********/


/**************PREMNOTAZIONI********************/

--Query
use db_abdf0e_fvitapegaso

go

--Header Prenotazione
--select * from reservations

--select	r.id,
--		r.pnr_code,
--		r.id_reservation_system,
--		rSys.reservation_system_code,
--		rSys.reservation_system_name,
--		r.id_origin_airport,
--		orig.iata_airport_code AS origin_iata_airport_code,
--		orig.airport_name as origin_airport_name,
--		cOrig.city_name as origin_city_name,
--		r.id_destination_airport,
--		dest.iata_airport_code as destination_iata_airport_code,
--		dest.airport_name as detination_airport_name,
--		cDest.city_name as detination_city_name,
--		r.round_trip,
--		case r.round_trip
--			when 0 then 'One Way'
--			when 1 then 'Round Trip'
--		end as tipo_viaggio,
--		r.departure_date,
--		r.return_date,
--		r.id_fare_type,
--		fare.fare_code,
--		fare.fare_name,
--		r.total_price,
--		r.discount,
--		case r.total_price
--			when null then null
--			else r.total_price - ISNULL(r.discount,0)
--		end as discounted_total_price,
--		r.id_payment_method,
--		pMeth.cod,
--		pMeth.method_name,
--		r.check_in,
--		case r.check_in
--			when 0 then 'Chek In is not available'
--			when 1 then 'Check In is available'
--		end as chek_in_availability,
--		r.checked_in,
--		case r.checked_in
--			when 0 then 'Check In not executed'
--			when 1 then 'Check In executed'
--		end as check_in_status,
--		r.owner_conditions_acceptance,
--		r.id_reservations_status,
--		rStat.cod,
--		rStat.status_name,
--		rStat.status_description
--from reservations r
--inner join reservation_systems rSys on r.id_reservation_system = rSys.id
--inner join airports orig on r.id_origin_airport = orig.id
--inner join cities cOrig on orig.city_id = cOrig.id
--inner join airports dest on r.id_destination_airport = dest.id
--inner join cities cDest on dest.city_id = cDest.id
--inner join fare_types fare on r.id_fare_type = fare.id
--left join payment_methods pMeth on r.id_payment_method = pMeth.id
--inner join reservations_statuses rStat on r.id_reservations_status = rStat.id

--Tratte della prenotazione
--select * from flight_schedules

--select	j.id_journey
--		, j.id_reservation
--		, r.pnr_code
--		, j.flight_segment_number
--		, j.id_flight_schedule
--		, fSched.id_flight
--		, a.airline_name
--		, f.iata_flight_code 
--		, orig.iata_airport_code as origin_iata_flight_code
--		, cOrig.city_name as origin_city_name
--		, dest.iata_airport_code as destination_iata_flight_code
--		, cDest.city_name as destnation_city_name
--		, pl.model
--		, fSched.departure_date
--		, fSched.departure_time
--		, fSched.arrival_date
--		, fSched.arrival_time
--from journeys j
--inner join reservations r on j.id_reservation = r.id
--inner join flight_schedules fSched on j.id_flight_schedule = fSched.id
--inner join airports orig on fSched.id_origin_airport = orig.id
--inner join cities cOrig on orig.city_id = cOrig.id
--inner join airports dest on fSched.id_destination_airport = dest.id
--inner join cities cDest on dest.city_id = cDest.id
--inner join flights f on fSched.id_flight = f.id
--inner join airlines a on f.id_airline = a.id
--inner join airplanes pl on fSched.id_airplane = pl.id
--order by j.id_reservation,j.flight_segment_number

--Passeggeri
--select * from users

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




