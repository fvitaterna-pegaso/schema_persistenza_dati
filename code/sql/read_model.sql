/**********
Nome Script		read_model.sql
Autore			Fabio Vitaterna
Descrizione		Query per use cases per il read model
Note			
**********/

use db_abdf0e_fvitapegaso

go

--Estrazione prenotazione

select * from reservations

select	r.id,
		r.pnr_code,
		r.id_reservation_system,
		rsys.reservation_system_code,
		rsys.reservation_system_name,
		r.id_origin_airport,
		orig.iata_airport_code,
		orig.airport_name,
		corig.city_name,
		r.id_destination_airport,
		dest.iata_airport_code,
		dest.airport_name,
		cdest.city_name,
		case r.round_trip
			when 0 then 'Solo Andata'
			when 1 then 'Andata/Ritorno'
		end as tipo_viaggio,
		r.departure_date,
		r.return_date,
		r.id_fare_type,
		fare.fare_code,
		fare.fare_name,
		r.total_price,
		r.discount,
		r.total_price - r.discount as discounted_total_price
from reservations r
inner join reservation_systems rsys on r.id_reservation_system = rsys.id
inner join airports orig on r.id_origin_airport = orig.id
inner join cities corig on orig.city_id = corig.id
inner join airports dest on r.id_destination_airport = dest.id
inner join cities cdest on dest.city_id = cdest.id
inner join fare_types fare on r.id_fare_type = fare.id