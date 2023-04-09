from fastapi import FastAPI
from app.db import Database

app = FastAPI()


@app.get("/")
def read_root():
    return {"Postgresql API feita por Matheus Costa e Felipe Bertoglio"}


app = FastAPI()
db = Database(
    host='host.docker.internal',
    port=5432,
    database='postgres',
    user='postgres',
    password='mypassword'
)


@app.on_event('startup')
async def startup_event():
    db.connect()


@app.on_event('shutdown')
async def shutdown_event():
    db.close()


@app.get('/users')
async def get_users():
    result = db.execute('SELECT * FROM Clientes')
    clientes = []
    for row in result:
        clientes.append({'id': row[0], 'nome': row[2], 'email': row[3]})
    return {'Clientes': clientes}

@app.get('/cliente')
async def get_client(nome:object):
    result = db.execute(f"SELECT * FROM Clientes WHERE nome='{nome}'")
    clientes = []
    for row in result:
        clientes.append({'id': row[0], 'nome': row[2], 'email': row[3]})
    return {'Clientes': clientes}
