from sqlalchemy import Column, Integer, String, Boolean, DateTime, Enum, Text
from sqlalchemy.sql import func
from enum import Enum as PyEnum
from enumerations.status import PriorityEnum, StatusEnum, TapeStatusEnum, VerifyEnum, Md5CompEnum, CharacterCheckEnum
from enumerations.tasks import TaskTypeEnum, ProcessEnum, PullFileTypeEnum
from enumerations.devices import LtoDbEnum, DeviceEnum, TapeFormatEnum, ExtendedTapeFormatEnum, EnumAsString
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import validates

Base = declarative_base()


class TapeMixin:
    project = Column(String(100), nullable=False)
    barcode = Column(String(10), nullable=False)
    wbbarcode = Column(String(55), nullable=True)
    tape_copy = Column(String(1), nullable=True)
    tocid = Column(Integer, nullable=True)
    # tape_format: Column(Enum(ExtendedTapeFormatEnum), nullable=True,
    #                     default=ExtendedTapeFormatEnum.LTFS)  # Doesnt Match all robots


class StatusMixin:
    task_error = Column(Text, nullable=True)
    status = Column(Enum(StatusEnum), nullable=False,
                    default=StatusEnum.PENDING)
    # tape_status = Column(Enum(TapeStatusEnum),
    #                      nullable=True, default=TapeStatusEnum.NA) # Doesnt Match all robots
    priority = Column(Enum(PriorityEnum), nullable=False,
                      default=PriorityEnum.NORMAL)
    verify = Column(Enum(VerifyEnum), default=VerifyEnum.NA, nullable=True)
    process = Column(Enum(ProcessEnum), default=ProcessEnum.NA, nullable=True)
    progress = Column(String(100), nullable=True)
    character_check = Column(Enum(CharacterCheckEnum),
                             nullable=False, default=CharacterCheckEnum.NO)
    md5_comp = Column(Enum(Md5CompEnum), nullable=False,
                      default=Md5CompEnum.NO)
    archive_comp = Column(Boolean, nullable=False, default=False)  # 'YES, NO'
    restore_comp = Column(Boolean, nullable=False, default=False)  # 'YES, NO'
    verify_comp = Column(Boolean, nullable=False, default=False)  # 'YES, NO'


class DeviceMixin:
    assigned_drive = Column(EnumAsString(DeviceEnum), nullable=True)
    drive_id = Column(EnumAsString(DeviceEnum), nullable=True)
    dev_id = Column(String(11), nullable=True)
    drive_serial = Column(String(11), nullable=True)
    slot = Column(Integer(), nullable=True)
    blk_size = Column(Integer(), nullable=False, default=0)
    fsf = Column(Integer(), nullable=False, default=0)
    log = Column(Text, nullable=True)


# FIX ME
class FilesystemMixin:
    src_count = Column(String(11), nullable=True)  # String?
    dest_count = Column(Integer(), nullable=True)
    src_size = Column(String(55), nullable=True)  # String?
    destsize = Column(Integer(), nullable=True)
    src_sizeGB = Column(String(11), nullable=True)
    md5id = Column(Integer, nullable=True)
    md5 = Column(Boolean, nullable=True, default=False)  # "YES, NO"
    # md5_path = Column(String(255), nullable=True)  # Doesnt Match all robots
    src_path = Column(String(255), nullable=True)
    edl_path = Column(String(255), nullable=True)
    dest_path = Column(String(255), nullable=False,
                       default='/mmfs1/dataio/lto_verifies')
    pull_paths = Column(Text, nullable=True)
    # pull_file_type = Column(Enum(PullFileTypeEnum),
    #                         nullable=True, default=PullFileTypeEnum.NA) # Doesnt Match all robots
    extensions = Column(String(30), nullable=True)
    exclusions = Column(String(11), nullable=True)
    host = Column(String(255), nullable=True)
    user = Column(String(30), nullable=True)


class TimestampMixin:
    # __abstract__ = True

    date_added = Column(DateTime, nullable=False, default=func.now())
    date_modified = Column(DateTime, nullable=False,
                           default=func.now(), onupdate=func.now())
    process_start = Column(DateTime, nullable=True)


class ltoTask(Base, TapeMixin, StatusMixin, DeviceMixin, FilesystemMixin, TimestampMixin):
    __tablename__ = 'tasks'

    id = Column(Integer, primary_key=True, index=True)
    task_name = Column(Text, nullable=True)
    task_type = Column(Enum(TaskTypeEnum), nullable=False,
                       default=TaskTypeEnum.ARCHIVE)
