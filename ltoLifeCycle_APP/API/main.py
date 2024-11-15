import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from routes import lto_lifecycle
from database import engine
from models.tasks import Base

current_file_path = os.path.abspath(__file__)
parent_directory = os.path.dirname(current_file_path)
print(f"Parent directory: {parent_directory}")

app = FastAPI(root_path="/api")
# root_path should match reverse proxy
# /etc/nginx/sites-available/your-project (congfig file)


def add_cors(app):
    # Define allowed origins
    origins = [
        "http://0.0.0.0:80",  # your frontend app URL
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


app.include_router(lto_lifecycle.router)
Base.metadata.create_all(bind=engine)
