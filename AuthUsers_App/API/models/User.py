from database import Base
from sqlalchemy import Column, Integer, String, Boolean, TIMESTAMP


class User(Base):
    __tablename__ = 'user'
    
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(100), unique=True)
    email = Column(String(100), unique=True)
    first_name = Column(String(50))
    last_name = Column(String(50))
    display_name = Column(String(50)) #ADD
    hashed_password = Column(String(100))
    is_active = Column(Boolean, default=True)
    role = Column(String(50))
    date_created = Column(TIMESTAMP) #ADD