
IF OBJECT_ID('cyclistic_2021') IS NOT NULL 
	DROP TABLE cyclistic_2021
GO 

CREATE TABLE cyclistic_2021
	(
	ride_id varchar(30),
	rideable_type varchar (30),
	started_at varchar (20),
	ended_at varchar (20),
	start_station_name varchar(125),
	start_station_id varchar(125),
	end_station_name varchar(125),
	end_station_id varchar(125),
	start_lat varchar(25),
	start_lng varchar(25),
	end_lat varchar(25),
	end_lng varchar(25),
	member_casual varchar(30),
	)
	GO
	
BULK INSERT cyclistic_2021
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202102-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO 

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202103-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202104-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202105-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202106-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202107-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202108-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202109-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO
BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202110-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202111-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202112-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202201-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

BULK INSERT cyclistic_2021 
FROM 'C:\Users\ibrah\Desktop\Extracted Data\202202-divvy-tripdata.csv'
WITH ( 
	FORMAT = 'CSV',
	FIRSTROW = 1 ,
	FIELDTERMINATOR = ',' ,
	ROWTERMINATOR =  '\n'
	) 
GO

delete
from cyclistic_2021
where ride_id='ride_id'


-- Responsible for created my tables with the desired data

;WITH 
cleaningdata AS 
	(SELECT 
	ride_id, 
	rideable_type,
	started_at,
	ended_at ,
	start_station_name ,
	start_station_id ,
	end_station_name ,
	end_station_id ,
	start_lat ,
	start_lng ,
	end_lat ,
	end_lng ,
	member_casual as member_status, 
	CONVERT(datetime, started_at, 120) as started_at_new,
	CONVERT(datetime, ended_at, 120) as ended_at_new,
	DATEDIFF(second,started_at, ended_at) AS seconds_difference,
	DATEDIFF(minute,started_at, ended_at) AS minutes_difference,
	DATEDIFF(month,2020/01/01, started_at) AS num_month,
	DATENAME(month, started_at) AS month_name,
	DATENAME(year, started_at) as year,
	convert(float,start_lat) as start_lat_new,
	convert(float,end_lat) as end_lat_new,
	convert(float,start_lng) as start_lng_new,
	convert(float,end_lng) as end_lng_new
	from cyclistic_2021),
final_data as 
	(
	SELECT
	ride_id, 
	rideable_type,
	started_at,
	ended_at ,
	seconds_difference, 
	minutes_difference,
	start_station_name ,
	start_station_id ,
	end_station_name ,
	end_station_id ,
	start_lat_new ,
	start_lng_new ,
	end_lat_new ,
	end_lng_new ,
	(end_lat_new - start_lat_new)*1000 as change_in_lat_1000_times,
	(end_lng_new-start_lng_new)*1000 as change_in_lng_1000_times,
	member_status,
	month_name, 
	num_month,
	year,
	month_name + ' ' + year as time_period,
	start_station_id + '-' + end_station_id as path_id
from cleaningdata)


-- Created temp tables to fix values into my desired values for analysis


---- Find Null Values 
--
--	select  
--		rideable_type, 
--		count(rideable_type) as number,
--		avg(seconds_difference) as avg_sec,
--		avg(minutes_difference) as avg_min, 
--		max(seconds_difference) as max_sec,
--		max(minutes_difference) as max_min, 
--		member_status
--	from 
--		final_data 
--	where 
--		end_lat_new is null 
--		or end_lng_new is null
----		-- or seconds_difference is null or start_lat_new is null or start_lng_new is null 
--	group by rideable_type, member_status
--	order by rideable_type, member_status
----	-- the above three never occur whereas the entierty of null values appear from ending locations not being registered. This probably means that the battery died
--	


----finding avg_values_not_null 
--	
--	select 
--	rideable_type, 
--	count(rideable_type) as number,
--	avg(seconds_difference) as avg_sec,
--	avg(minutes_difference) as avg_min, 
--	avg(change_in_lat_1000_times) as avg_lat_1000_times, 
--	avg(change_in_lng_1000_times) as avg_lng_1000_times,
--	member_status
--	from final_data 
--	where 
--		end_lat_new is not null 
--		or end_lng_new is not null
--	group by rideable_type, member_status
--	order by number,rideable_type, member_status
----	


---- finding exact_location 
	--select 
	--rideable_type, 
	--count(rideable_type) as number,
	--avg(seconds_difference) as avg_sec,
	--avg(minutes_difference) as avg_min, 
	--avg(change_in_lat_1000_times) as avg_lat_1000_times, 
	--avg(change_in_lng_1000_times) as avg_lng_1000_times,
	--member_status
	--from final_data 
	--where 
	--	end_lat_new = start_lat_new 
	--	and end_lng_new = start_lng_new
	--group by rideable_type, member_status
	--order by member_status, rideable_type 
--	-- on average, it appears for leaving and returning in the same location, the casual member would use the buke for a signifigantly longer period of time. Almost 2-3 times on average
--	-- could be because the barrier of entry for member to rent a bike are much lower than casual members 
--	-- could also be that casual members treat bike riding as more of an activity/outing/last resort than a daily occurance as compared to usual members


---- gives an easier to visulaize estimate of difference traveled 
--select 
--	time_period, 
--	count(ride_id) as number,
--	--avg(seconds_difference) as avg_sec,
--	avg(minutes_difference) as avg_min, 
--	--avg(change_in_lat_1000_times)/1000 as avg_lat_change, 
--	--avg(change_in_lng_1000_times)/1000 as avg_lng_change,
--	avg(change_in_lat_1000_times)*100 as avg_lat_change_100000_times, 
--	avg(change_in_lng_1000_times)*100 as avg_lng_change_100000_times,
--	abs(avg(change_in_lat_1000_times)*100) + abs(avg(change_in_lng_1000_times)*100) as rough_est_dist_change_100000x,
--	member_status
--from final_data 
--where 
--		(end_lat_new is not null or 
--		end_lng_new is not null )
--		--and member_status= 'casual'
--group by num_month,time_period, member_status
--order by num_month, member_status

---- seperate by months of the year and find months with most traffic 
---- rate of 2-3x is consistent with other findings, 



---- below are two seperate routes i took to combine data tables, I ulttimately focused on the union because it fit my criteria better 

--SELECT 
--count(a.ride_id) as number_of_rides,
--a.time_period,
--a.path_id,
--a.member_status,
--CAST(a.lat as decimal(10,6)) as lat, 
--CAST(a.lng as decimal(10,6)) as lng,
--CAST(b.lat as decimal(10,6)) as lat,
--CAST(b.lng as decimal(10,6)) as lng,
--b.time_period,
--b.path_id,
--b.member_status
--FROM 
--	(
--	SELECT 
--	ride_id,
--	time_period,
--	path_id,
--	member_status,
--	start_lat_new as lat,
--	start_lng_new as lng
--	from final_data
--	where start_lat_new is not null AND start_lng_new is not null 
--	) as a 
--LEFT JOIN 
--	(
--	SELECT
--	ride_id,
--	time_period,
--	path_id,
--	member_status,
--	end_lat_new as lat,
--	end_lng_new as lng
--	from final_data
--	where end_lat_new is not null AND end_lng_new is not null 
--	) as b
--on 
--a.path_id=b.path_id and a.time_period = b.time_period and a.member_status = b.member_status and a.ride_id=b.ride_id 
--where a.lat=b.lat and a.lng=b.lng
--group by a.path_id, a.time_period, a.member_status, b.time_period, b.path_id, b.member_status, CAST(a.lat as decimal(10,6)), CAST(a.lng as decimal(10,6)),CAST(b.lat as decimal(10,6)),CAST(b.lng as decimal(10,6))   
----having count(a.ride_id)> 100 
--order by a.path_id,count(a.ride_id) desc, a.member_status 


Select
'Origin' as origin_destination, 
count(ride_id) as number_of_rides,
path_id,
member_status, 
start_lat_new as lat,
start_lng_new as lng
from final_data
where start_station_id is not null AND end_station_id is not null and end_lat_new is not null AND end_lng_new is not null and start_lat_new is not null AND start_lng_new is not null
group by path_id, member_status, start_lat_new, start_lng_new
having count(ride_id) > 200

union all 

Select
'Destination' as origin_destination,
count(ride_id) as number_of_rides,
path_id,
member_status, 
end_lat_new as lat,
end_lng_new as lng
from final_data
where start_station_id is not null AND end_station_id is not null and end_lat_new is not null AND end_lng_new is not null and start_lat_new is not null AND start_lng_new is not null

group by path_id, member_status, end_lat_new, end_lng_new
having count(ride_id) > 200
order by count(ride_id) desc, origin_destination , member_status 


