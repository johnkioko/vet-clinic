/*Queries that provide answers to the questions from all projects.*/

SELECT *FROM animals WHERE name LIKE '%mon%';
SELECT *FROM animals WHERE '[2016-01-01, 2019-12-31]'::DATERANGE @> date_of_birth;
SELECT *FROM animals WHERE neutered = 'True' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT *FROM animals WHERE neutered = 'True';
SELECT *FROM animals WHERE name != 'Gabumon';
SELECT *FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT species from animals;

ROLLBACK;

SELECT species from animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

SELECT species from animals;

BEGIN;

DELETE FROM animals;
SELECT *FROM animals;
ROLLBACK;
SELECT *FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth  > '2022-01-02';
SAVEPOINT delete_2022;
UPDATE animals SET  weight_kg = ( weight_kg * -1);
ROLLBACK TO delete_2022;
UPDATE animals SET  weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


/* Day 3 */

SELECT *FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT name AS name_of_animals, full_name AS name_of_owners FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM animals
LEFT JOIN species ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name FROM animals
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell' ;

SELECT name FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT full_name, COUNT(full_name) AS maximum FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY maximum
DESC LIMIT 1;

/* Day 4 */

SELECT animals.name FROM visits
JOIN animals on animals.id = visits.animals_id
JOIN vets on vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit
DESC LIMIT 1;

SELECT vets.name, COUNT(*) FROM visits
JOIN animals on animals.id = visits.animals_id
JOIN vets on vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

SELECT vets.name, species.name FROM vets
LEFT JOIN specializations on vets.id = specializations.vets_id
LEFT JOIN species on species.id = specializations.species_id;

SELECT animals.name FROM visits
JOIN vets on vets.id = visits.vets_id
JOIN animals on animals.id = visits.animals_id
WHERE vets.name = 'Stephanie Mendez'
AND date_of_visit BETWEEN '04-01-2020' AND '08-30-2020';

SELECT animals.name, COUNT(*) AS number_of_visits FROM visits
JOIN vets on vets.id = visits.vets_id
JOIN animals on animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY number_of_visits
DESC LIMIT 1;

SELECT animals.name FROM visits
JOIN vets on vets.id = visits.vets_id
JOIN animals on animals.id = visits.animals_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
LIMIT 1;

SELECT animals.name, vets.name, date_of_visit FROM visits
JOIN vets on vets.id = visits.vets_id
JOIN animals on animals.id = visits.animals_id
ORDER BY date_of_visit
DESC LIMIT 1;

SELECT COUNT(*) FROM vets
LEFT JOIN visits on vets.id = visits.vets_id
LEFT JOIN specializations on vets.id = specializations.vets_id
LEFT JOIN species on species.id = specializations.species_id
WHERE species.name is NULL;

SELECT species.name, COUNT(*) FROM visits
JOIN vets on vets.id = visits.vets_id
JOIN animals on animals.id = visits.animals_id
JOIN species on species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
LIMIT 1;
