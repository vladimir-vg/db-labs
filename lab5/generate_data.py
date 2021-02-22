import psycopg2
from faker import Faker
from random import randrange

con = psycopg2.connect(
    database="lab6",
    user="postgres",
    password='postgres',
    host="127.0.0.1",
    port="5432")

fake = Faker()

def gen_record(id):
    return "('"+ str(id)+"','"+fake.name()+"','"+fake.address()+"','"+str(randrange(15,85))+"','"+fake.text()+"')"

def gen_values(offset, n):
    return ','.join([gen_record(offset+i) for i in range(n)])

cur = con.cursor()
chunk_size = 1000
for i in range(300):
    print(i)
    values = gen_values(i*chunk_size, chunk_size)
    cur.execute("INSERT INTO customers (id,name,address,age,review) VALUES " + values)
    con.commit()
