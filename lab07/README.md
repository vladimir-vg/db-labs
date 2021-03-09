# add columns

```
ALTER TABLE address ADD COLUMN longitude DECIMAL(10,6);
ALTER TABLE address ADD COLUMN latitude DECIMAL(10,6);
```

# create function

```
CREATE OR REPLACE FUNCTION addressesWithEleven()
  RETURNS TABLE(address_id int, address text) AS
$$
BEGIN

  RETURN  QUERY
    SELECT address.address_id, address.address::text
    FROM address
    WHERE (address.city_id BETWEEN 400 AND 600)
      AND address.address LIKE '%11%';

END; $$
LANGUAGE plpgsql;
```
