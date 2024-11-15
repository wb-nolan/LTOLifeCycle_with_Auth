import sys
sys.path.append('/home/ltoLifeCycle_APP/')
from datetime import datetime, timedelta
from typing import Annotated, List
from fastapi import APIRouter, Depends, HTTPException, Path, Query
from starlette import status
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from API.database import SessionLocal, all_lto_db
from API.models.tasks import ltoTask
from API.models.khltos import khlto_001, khlto_002, khlto_003, khlto_004, khlto_005
from API.schema.tasks import TaskSchemaResponse  # ltoTaskSchema
from API.enumerations.status import PriorityEnum, StatusEnum, TapeStatusEnum, VerifyEnum, Md5CompEnum, CharacterCheckEnum
from API.enumerations.tasks import TaskTypeEnum, ProcessEnum, PullFileTypeEnum
from API.enumerations.devices import LtoDbEnum, DeviceEnum, TapeFormatEnum, ExtendedTapeFormatEnum
from typing import Optional
from API.helper import convert_dates


router = APIRouter(
    prefix='/lto_lifecycle',
    tags=['LTO Lifecycle']
)

available_projects: List = []

@router.on_event("startup")
async def startup_event():
    global available_projects
    await get_projects()

async def get_projects() -> List[str]:
    projects = set()
    for _, session in all_lto_db():
        distinct_projects = session.query(ltoTask.project).distinct().all()
        projects.update(p[0] for p in distinct_projects if p[0])
    projects = sorted(projects)
    for p in projects:
        available_projects.append(p)


@router.get('/{status}', response_model=List[TaskSchemaResponse])
def show_task(
    status: StatusEnum = StatusEnum.COMPLETE,
    days: int = Query(14, description='Limit Date (Default: 14 days)'),
    limit: Optional[int] = Query(
        50, ge=1, le=200, description='Limit Results'),
    project: Optional[str] = Query(
        None, description='Select a Project', enum=available_projects)
):
    all_tasks = []
    if days and days > 0:
        threshold_date = datetime.now() - timedelta(days=days)
        for hostname, session in all_lto_db():
            query = session.query(ltoTask).filter(
                ltoTask.status == status,
                ltoTask.date_modified >= threshold_date
            )
            if project:
                query = query.filter(ltoTask.project == project)

            tasks = query.order_by(ltoTask.date_modified.desc()).limit(limit).all()
            
            if tasks:
                for task in tasks:
                    convert_dates(task)
                    setattr(task, 'hostname', hostname)
                all_tasks.extend(tasks)
    else:
        for hostname, session in all_lto_db():
            tasks = session.query(ltoTask).filter(
                ltoTask.status == status).limit(limit).all()
            if tasks:
                for task in tasks:
                    convert_dates(task)
                    setattr(task, 'hostname', hostname)
                    all_tasks.extend(tasks)
            
    if not all_tasks:
        raise HTTPException(
            status_code=404, detail=f'No Task with Status: {status} found'
        )
        
    print(len(all_tasks))
    
    return all_tasks

# FIX FILESYSTEM SCEHEMA RESPONSE ##
# BARCODE FILTER FRONT END?
