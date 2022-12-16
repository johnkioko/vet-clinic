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

ROLLBACK;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

BEGIN;
DELETE FROM animals WHERE date_of_birth  > '2022-01-02';
SAVEPOINT delete_2022;
UPDATE animals SET  weight_kg = ( weight_kg * -1);
ROLLBACK TO delete_2022;
UPDATE animals SET  weight_kg = ( weight_kg * -1) WHERE id IN (7,5,8,6);
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY neutered;