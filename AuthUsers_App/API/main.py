from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from routes import auth, admin
from database import engine, Base
import sys 
sys.path.append('/home/')
from ltoLifeCycle_APP.API.routes import lto_lifecycle


app = FastAPI(root_path="/api")
# root_path should match reverse proxy 
# /etc/nginx/sites-available/your-project (congfig file)


def add_cors(app):
    # Define allowed origins
    origins = [
        "http://0.0.0.0:80",  # your frontend app URL
        'http://127.0.0.1:3000'
    ]

    # Add CORS middleware
    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,  # Allows specific origins
        allow_credentials=True,
        allow_methods=["*"],  # Allows all HTTP methods
        allow_headers=["*"],  # Allows all headers
    )

add_cors(app)


app.include_router(auth.router)
app.include_router(admin.router)

app.include_router(lto_lifecycle.router)

Base.metadata.create_all(bind=engine)