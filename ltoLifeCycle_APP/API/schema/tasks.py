from pydantic import BaseModel, Field
from datetime import datetime
from enum import Enum
from ..enumerations.status import PriorityEnum, StatusEnum, TapeStatusEnum, VerifyEnum, Md5CompEnum, CharacterCheckEnum
from ..enumerations.tasks import TaskTypeEnum, ProcessEnum, PullFileTypeEnum
from ..enumerations.devices import LtoDbEnum, DeviceEnum, TapeFormatEnum, ExtendedTapeFormatEnum, EnumAsString
from typing import Optional, List


class TapeSchema(BaseModel):
    project: str
    barcode: str
    wbbarcode: Optional[str] = None
    tape_copy: Optional[str] = None
    tocid: Optional[int] = 0
    # tape_format: Optional[ExtendedTapeFormatEnum] = None #


class StatusSchema(BaseModel):
    task_error: Optional[str] = None
    status: StatusEnum = StatusEnum.PENDING
    # tape_status: Optional[TapeStatusEnum] = TapeStatusEnum.NA #
    priority: PriorityEnum = PriorityEnum.NORMAL
    verify: Optional[VerifyEnum] = VerifyEnum.NA
    process: Optional[ProcessEnum] = ProcessEnum.NA
    progress: Optional[str] = None
    character_check: CharacterCheckEnum = CharacterCheckEnum.NO
    md5_comp: Md5CompEnum = Md5CompEnum.NO
    archive_comp: bool = False
    restore_comp: Optional[bool] = False
    verify_comp: Optional[bool] = False
    


class DeviceSchema(BaseModel):
    assigned_drive: Optional[DeviceEnum]  # DeviceEnum "0" Error
    drive_id: Optional[DeviceEnum] # DeviceEnum "0" Error
    dev_id: Optional[str] = None
    drive_serial: Optional[str] = None
    slot: Optional[int] = None
    blk_size: int = 0
    fsf: int = 0
    log: Optional[str] = None

# FIX ME


class FilesystemSchema(BaseModel):
    src_count: Optional[str] = None
    dest_count: Optional[int] = 0
    src_size: Optional[str] = None  # int?
    destsize: Optional[int] = None  # int?
    src_sizeGB: Optional[str] = None
    md5id: Optional[int] = None
    md5: bool = False
    # md5_path: Optional[str] = None
    src_path: Optional[str] = None
    edl_path: Optional[str] = None
    dest_path: str = '/mmfs1/dataio/lto_verifies'
    pull_paths: Optional[str] = None
    # pull_file_type: Optional[PullFileTypeEnum] = PullFileTypeEnum.NA # Not on khlto_002
    extensions: Optional[str] = None
    exclusions: Optional[str] = None
    fps: Optional[int] = None # Not on khlto_002
    host: Optional[str] = None
    user: Optional[str] = None
    verify_deleted: Optional[str] = 'NO'


class TimestampSchema(BaseModel):
    date_added: Optional[datetime] = None
    date_modified: Optional[datetime] = None
    process_start: Optional[datetime] = None


class ltoTaskSchema(TimestampSchema, FilesystemSchema, DeviceSchema, StatusSchema, TapeSchema):

    task_name: Optional[str] = None
    task_type: TaskTypeEnum = TapeStatusEnum.NA
    id: int
    
    class Config:
        orm_mode = True


class TaskSchemaResponse(ltoTaskSchema):
    id: int
    hostname: Optional[str] = None

    class Config:
        orm_mode = True
