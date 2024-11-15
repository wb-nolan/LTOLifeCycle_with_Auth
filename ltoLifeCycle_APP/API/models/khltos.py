from .tasks import ltoTask
from sqlalchemy import Column, Enum, Boolean
from sqlalchemy.orm import mapped_column
from enum import Enum as PyEnum
from ..enumerations.devices import TapeFormatEnum, ExtendedTapeFormatEnum
from ..enumerations.status import TapeStatusEnum


class khlto_001(ltoTask):
    pass
    # tape_format = Column(Enum(TapeFormatEnum),
                        #  nullable=False, default=TapeFormatEnum.LTFS)
    # pull_file_type = Column(Enum(PullFileTypeEnum),
                            # nullable=False, default=PullFileTypeEnum.NA)
    # fps = Column(Integer(), nullable=True)

class khlto_002(ltoTask):
    pass
    # tape_format = Column(Enum(ExtendedTapeFormatEnum),
                        #  nullable=False, default=ExtendedTapeFormatEnum.LTFS) # Adds BRU


class khlto_003(ltoTask):
    pass
    # pull_file_type = Column(Enum(PullFileTypeEnum),
                            # nullable=False, default=PullFileTypeEnum.NA)
    # tape_format = Column(Enum(TapeFormatEnum),
                        #  nullable=False, default=TapeFormatEnum.LTFS)
    # fps = Column(Integer(), nullable=True)

class khlto_004(ltoTask):
    pass
    # pull_file_type = Column(Enum(PullFileTypeEnum),
                            # nullable=False, default=PullFileTypeEnum.NA)
    # md5_path = Column(String(255), nullable=False)
    # tape_format = Column(Enum(TapeFormatEnum),
                        #  nullable=False, default=TapeFormatEnum.LTFS)
    # tape_status = Column(Enum(TapeStatusEnum),
                        #  nullable=True, default=TapeStatusEnum.NA)
    # verify_deleted = Column(Boolean, nullable=True)
    # fps = Column(Integer(), nullable=True)

class khlto_005(ltoTask):
    pass
    # pull_file_type = Column(Enum(PullFileTypeEnum),
                            # nullable=False, default=PullFileTypeEnum.NA)
    # md5_path = Column(String(255), nullable=False)
    # tape_format = Column(Enum(TapeFormatEnum),
                        #  nullable=False, default=TapeFormatEnum.LTFS)
    # tape_status = Column(Enum(TapeStatusEnum),
                        #  nullable=True, default=TapeStatusEnum.NA)
    # verify_deleted = Column(Boolean, nullable=True)
    # fps = Column(Integer(), nullable=True)
