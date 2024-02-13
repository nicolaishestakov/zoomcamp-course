-- Create tables from 2022 green taxi trips data

CREATE OR REPLACE EXTERNAL TABLE `careful-muse-411920.hw3_green_taxi.external_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris=['gs://hw3-green-taxi-2022/green_tripdata_2022-*.parquet'] -- I uploaded the files manually to the bucket because I had issues with timestamps when processing them via mage/pandas
);

--Q1
SELECT COUNT(*) FROM careful-muse-411920.hw3_green_taxi.external_tripdata;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `careful-muse-411920.hw3_green_taxi.tripdata` AS
SELECT * FROM careful-muse-411920.hw3_green_taxi.external_tripdata;

--Q2
SELECT COUNT (DISTINCT PULocationID) FROM careful-muse-411920.hw3_green_taxi.external_tripdata;
SELECT COUNT(DISTINCT PULocationID) FROM careful-muse-411920.hw3_green_taxi.tripdata;

--Q3
SELECT COUNT(*) FROM careful-muse-411920.hw3_green_taxi.tripdata WHERE fare_amount = 0;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE careful-muse-411920.hw3_green_taxi.tripdata_partitioned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM careful-muse-411920.hw3_green_taxi.external_tripdata;

--Q5
--retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
SELECT DISTINCT PULocationID
FROM careful-muse-411920.hw3_green_taxi.tripdata_partitioned_clustered
WHERE  lpep_pickup_datetime >= '2022-06-01' AND lpep_pickup_datetime < '2022-07-01';

SELECT DISTINCT PULocationID
FROM careful-muse-411920.hw3_green_taxi.tripdata
WHERE  lpep_pickup_datetime >= '2022-06-01' AND lpep_pickup_datetime < '2022-07-01';


--Q8
-- I guess the total row count of the table is known without querying the actual rows
SELECT COUNT(*) FROM careful-muse-411920.hw3_green_taxi.tripdata_partitioned_clustered; --0 bytes
SELECT COUNT(*) FROM careful-muse-411920.hw3_green_taxi.tripdata; -- 0 bytes


