from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Postgresql API feita por Matheus Costa e Felipe Bertoglio"}
