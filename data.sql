/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon','2020-02-03', 0, 'yes', 10.23 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Gabumon','2018-11-15', 2, 'yes', 8 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Pikachu','2021-01-07', 1, 'false', 15.04 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Devimon','2017-05-12', 5, 'yes', 11 );

/* Insert more rows into the animals table */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Charmander','2020-02-08', 0, 'false', -11 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Plantmon','2021-11-15', 2, 'True', -5.7 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Squirtle','1993-04-02', 3, 'false', -12.13 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Angemon','2005-06-12', 1, 'True', -45 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Boarmon','2005-06-07', 7, 'True', 20.4 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Blossom','1998-10-13', 3, 'True', 17 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Ditto','2022-05-14', 4, 'True', 22 );

/* Day 3 */

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittake', 38);

INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

/*Modify your inserted animals so it includes the species_id value*/

UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals
   SET species_id = (SELECT id from species WHERE name = 'Pokemon')
   WHERE species_id IS NULL;

/*Modify your inserted animals to include owner information (owner_id)*/

UPDATE animals SET owner_id = 1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon','Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon','Boarmon');