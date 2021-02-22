CREATE TABLE customers (
  id SERIAL,
  name TEXT,
  address TEXT,
  age INTEGER,
  review TEXT
);


-- CREATE INDEX age_btree ON customers USING btree (age);
-- CREATE INDEX name_hash ON customers USING hash (name);
-- CREATE INDEX review_gin ON customers USING gin (to_tsvector('english', review));
-- CREATE INDEX review_gist ON customers USING gist (to_tsvector('english', review));
