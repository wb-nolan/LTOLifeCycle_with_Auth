from pydantic import BaseModel, Field
from datetime import datetime

class CreateUserRequest(BaseModel):
    username: str
    email: str
    first_name: str
    last_name: str
    display_name: str
    password: str
    role: str
    date_created:  datetime = Field(default_factory=datetime.now)