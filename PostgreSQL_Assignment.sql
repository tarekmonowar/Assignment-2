-- Active: 1747475407133@@127.0.0.1@5432@test1

-- This is ASSIGNMENT-2 For PostgresSQL
-- Create Rangers Table

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);


-- Create Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL  CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic'))
);

-- Create Sightings Table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);

--  Insert  data in Rangers Table

INSERT INTO rangers ( name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Tarek Monowar', 'Forest Edge'),
('Janker Mahbub', 'Level1 Edge'),
('Proggraming Hero', 'Level2 Range');


--  Insert  data in Species Table

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Panda', 'Panthera obscura', '1900-01-01', 'Vulnerable'),
('Sanda', 'Sandenio Guteres', '2025-05-20', 'Endangered');


--  Insert  data in Sightings Table

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 3, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(5, 6, 'Bankwood Pass', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 5, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(5, 3, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(2, 5, 'Green Hollow', '2024-05-20 10:00:00', 'Two individuals spotted');


select * from rangers

select * from sightings

select * from species



--Problem 1️: Register a new ranger
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');



-- Problem 2: Count unique species ever sighted
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;




--Problem 3️ : Find all sightings where the location includes "Pass"

SELECT * FROM sightings
WHERE location LIKE '%Pass%';


--Problem 4️: List each ranger's name and their total number of sightings

SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers 
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name , rangers.ranger_id;



--Problem 5️: List species that have never been sighted


SELECT common_name
FROM species
WHERE species_id NOT IN (
    SELECT DISTINCT species_id FROM sightings
);



--Problem 6️ : Show the most recent 2 sightings


SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings 
JOIN species ON sightings.species_id = species.species_id
JOIN rangers  ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2; 


--Problem 7️: Update species discovered before year 1800 to have status 'Historic'

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


--Problem 8️: Label each sighting's time of day
SELECT 
    sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;




--Problem 9️ : Delete rangers who have never sighted any species

DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);