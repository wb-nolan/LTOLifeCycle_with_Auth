from typing import Annotated
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, HTTPException, Path
from starlette import status
from models.User import User
from database import SessionLocal, get_db
from .auth import get_current_user

router = APIRouter(
    prefix='/admin',
    tags=['admin']
)


db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]


@router.get('/users', status_code=status.HTTP_200_OK)
async def read_all(db: db_dependency, user: user_dependency, ):
    if user is None or user.get('user_role') != 'admin':
        raise HTTPException(status_code=401, detail='Authentication Failed')
    return db.query(User).all()

@router.delete('/user/{user_id}', status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(user: user_dependency, db: db_dependency, user_id: int = Path(gt=0)):
    if user is None or user.get('user_role') != 'admin':
        raise HTTPException(status_code=401, detail='Authentication Failed')
    user_model = db.query(User).filter(User.id == user_id).first()
    if user_model is None:
        raise HTTPException(status_code=404, detail='User not Found')
    db.query(User).filter(User.id == user_id).delete()
    db.commit()
