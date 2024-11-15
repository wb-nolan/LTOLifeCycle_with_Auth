from .tasks import ltoTaskSchema
from ..enumerations import TapeFormatEnum, ExtendedTapeFormatEnum

class khlto001Schema(ltoTaskSchema):
    tape_format: TapeFormatEnum = TapeFormatEnum.LTFS


class khlto002Schema(ltoTaskSchema):
    tape_format: ExtendedTapeFormatEnum = ExtendedTapeFormatEnum.LTFS


class khlto003Schema(ltoTaskSchema):
    tape_format: TapeFormatEnum = TapeFormatEnum.LTFS


class khlto004Schema(ltoTaskSchema):
    tape_format: TapeFormatEnum = TapeFormatEnum.LTFS
    tape_status: Optional[TapeStatusEnum] = None
    verify_deleted: bool = False


class khlto005Schema(ltoTaskSchema):
    tape_format: TapeFormatEnum = TapeFormatEnum.LTFS
    tape_status: Optional[TapeStatusEnum] = None
    verify_deleted: bool = False
