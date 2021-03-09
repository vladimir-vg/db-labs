import psycopg2
import time
from geopy.geocoders import Nominatim


con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="postgres", host="127.0.0.1", port="5432")

cur = con.cursor()
cur.execute("SELECT * FROM addressesWithEleven()");
rows = cur.fetchall()
print(rows)

geolocator = Nominatim(user_agent="DatabaseLab07-Vladimir-Gordeev")
for row in rows:
    location = geolocator.geocode(row[1])
    if location:
        cur.execute("UPDATE address SET longitude = %s, latitude = %s WHERE address_id = %s",
                    (location.longitude, location.latitude, row[0]))
    else:
        cur.execute("UPDATE address SET longitude = %s, latitude = %s WHERE address_id = %s",
        (0, 0, row[0]))

    # need to sleep, so geolocation service would not ban us
    time.sleep(1)

con.commit();
print(location)
