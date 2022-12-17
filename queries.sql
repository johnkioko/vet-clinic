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

SELECT name FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
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
