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
