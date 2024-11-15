from sqlalchemy.types import TypeDecorator, String
from enum import Enum as PyEnum
from sqlalchemy.types import TypeDecorator, Enum

# print(device.assigned_drive)  # Output: DeviceEnum.one
# print(device.assigned_drive.value)  # Output: 1
class DeviceEnum(str, PyEnum):
    zero = '0'
    one = '1'
    two = '2'
    three = '3'

class EnumAsString(TypeDecorator):
    impl = String  
    def __init__(self, enum_class):
        self.enum_class = enum_class
        super().__init__()

    # Storing the Enum: The process_bind_param method converts a Python DeviceEnum 
    # (like DeviceEnum.one) into its corresponding string value (like '1') 
    # before storing it in the database.
    def process_bind_param(self, value, dialect): 
        if isinstance(value, self.enum_class):
            return value.value  
        return value  

    # Retrieving the Enum: The process_result_value method converts the 
    # string value from the database (like '1') back into a DeviceEnum 
    # instance (like DeviceEnum.one).
    def process_result_value(self, value, dialect):
        if value is not None:
            return self.enum_class(value)
        return None



class LtoDbEnum(str, PyEnum):

    khlto_001 = 'khlto-001'
    khlto_002 = 'khlto-002'
    khlto_003 = 'khlto-003'
    khlto_004 = 'khlto-004'
    khlto_005 = 'khlto-005'



class TapeFormatEnum(str, PyEnum):
    LTFS = 'LTFS'
    TAR = 'TAR'

class ExtendedTapeFormatEnum(str, PyEnum):
    LTFS = 'LTFS'
    TAR = 'TAR'
    BRU = 'BRU'  # 002
