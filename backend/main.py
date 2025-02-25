from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import requests
from sqlalchemy import create_engine, Column, Integer, String, Float, Date
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

NBP_API_URL = "https://api.nbp.pl/api/exchangerates/"

database_url = os.getenv("DATABASE_URL", "postgresql://admin:AplikacjaWaluty123@db/waluty")
engine = create_engine(database_url)
SessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)
Base = declarative_base()

class ExchangeRate(Base):
    __tablename__ = "exchange_rates"
    id = Column(Integer, primary_key=True, index=True)
    currency = Column(String, index=True)
    code = Column(String, index=True)
    rate = Column(Float)
    date = Column(Date)

@app.on_event("startup")
def startup():
    Base.metadata.create_all(bind=engine)

@app.get("/")
def read_root():
    return {"message": "API działa"}

@app.get("/latest-rates/")
def get_latest_rates(table_type: str = "A", code: str = "all"):
    if code != "all":
        url = f"{NBP_API_URL}/rates/{table_type}/USD/?format=json"
    else:
        url = f"{NBP_API_URL}/tables/{table_type}/?format=json"
    response = requests.get(url)
    if response.status_code == 500:
        raise HTTPException(status_code=500, detail="Nie można pobrać najnowszego kursu.")
    data = response.json()
    if isinstance(data, list):
            data = data[0]
    if "rates" not in data:
        data = {
            "effectiveDate": data.get("effectiveDate", ""),
            "rates": [data]
        }
    return data

@app.get("/rates-date/")
def get_rates_for_date(date: str, table_type: str = "A", code: str = "all"):
    if code != "all":
        url = f"{NBP_API_URL}/rates/{table_type}/{code}/{date}/?format=json"
    else:
        url = f"{NBP_API_URL}/tables/{table_type}/{date}/?format=json"
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Nie można pobrać kursu dla dnia: {date}.")
    data = response.json()
    if isinstance(data, list):
            data = data[0]
    if "rates" not in data:
        data = {
            "effectiveDate": data.get("effectiveDate", ""),
            "rates": [data]
        }
    return data

@app.get("/rates-range/")
def get_rates_for_range(start: str, end: str, table_type: str = "A", code: str = "all"):
    if code != "all":
        url = f"{NBP_API_URL}/rates/{table_type}/{code}/{start}/{end}/?format=json"
    else:
        url = f"{NBP_API_URL}/tables/{table_type}/{start}/{end}/?format=json"
    
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(
            status_code=500,
            detail=f"Nie można pobrać kursu dla zakresu: {start} - {end}"
        )
    data = response.json()
    
    if code != "all":       
        transformed = []
        rates_list = data.get("rates", [])
        for rate in rates_list:
            transformed.append({
                "effectiveDate": rate.get("effectiveDate"),
                "rates": [{                    
                    "mid": rate.get("mid"),
                    "ask": rate.get("ask"),
                    "bid": rate.get("bid")
                }]
            })
        return transformed
    else:      
        return data

@app.get("/currencies/")
def get_available_currencies():
    url = f"{NBP_API_URL}/tables/A/?format=json"
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(status_code=500, detail="Nie można pobrać listy walut")
    data = response.json()
    codes = data[0].get("rates", [])
    currencyArr = []
    for item in codes:        
        if item["code"] not in currencyArr:
            currencyArr.append(item["code"])
    return currencyArr