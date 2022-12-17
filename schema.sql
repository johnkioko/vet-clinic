/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

/* Updating table */

/* Add a new column */

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/* Day 3 */

CREATE TABLE owners(
    id SERIAL NOT NULL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100)
);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id)
;

/* Day 4 */

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vets_id INTEGER REFERENCES vets(id) ON DELETE CASCADE,
	species_id INTEGER REFERENCES species(id) ON DELETE CASCADE
);

CREATE TABLE visits (
    vets_id INTEGER REFERENCES vets(id) ON DELETE CASCADE,
	animals_id INTEGER REFERENCES animals(id) ON DELETE CASCADE,
	date_of_visit DATE
);