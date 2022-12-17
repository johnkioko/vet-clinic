/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY(1,1) NOT NULL PRIMARY KEY,
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