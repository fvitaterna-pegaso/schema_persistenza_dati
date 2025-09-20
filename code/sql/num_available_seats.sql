with cteTotSeats as (
	select COUNT(*) as num_seats
	from airplane_seats
	where id_airplane = 10 and id_fare_type_family = 1
),
cteTakenSeats as (
select COUNT(*) as num_taken_seats
from flight_schedule_seats fss
inner join fare_types ft on fss.id_fare_type = ft.id
inner join fare_type_families ftf on ft.id_fare_type_family = ftf.id
where fss.id_journey = 3 and ftf.id = 1
)
select tot.num_seats - tak.num_taken_seats as num_avail_seats
from cteTotSeats tot
cross join cteTakenSeats tak;






