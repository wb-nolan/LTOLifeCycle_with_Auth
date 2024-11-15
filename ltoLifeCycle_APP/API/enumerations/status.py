from enum import Enum as PyEnum


# Context of Status meaning

class StatusEnum(str, PyEnum): 

    def __init__(self, value):
        self._value_ = value

    COMPLETE = 'COMPLETE'
    TAPE_LOADED = 'TAPE_LOADED'
    IN_PROGRESS = 'IN_PROGRESS'
    WRITING = 'WRITING'
    RESTORING = 'RESTORING'
    VERIFYING = 'VERIFYING'
    FAILED = 'FAILED'
    CANCEL = 'CANCEL'
    WAITING = 'WAITING'
    PENDING_EJECT = 'PENDING_EJECT'
    ON_HOLD = 'ON_HOLD'
    PENDING = 'PENDING'
    READY = 'READY'
    ERROR = 'ERROR'

    @property  # 14 Ranks
    def rank(self): 
        ranks = {
            'FAILED': -5,
            'ERROR': -4,
            'ON_HOLD': -3,
            'CANCEL': -2,
            'WAITING': -1,
            'PENDING':  0,
            'TAPE_LOADED': 1,
            'READY': 2,
            'IN_PROGRESS': 3,
            'RESTORING': 4,
            'WRITING': 5,
            'VERIFYING': 6,
            'PENDING_EJECT': 7,
            'COMPLETE': 8,
        }
        return ranks.get(self._value_, 0)


class TapeStatusEnum(str, PyEnum):

    def __init__(self, value):
        self._value_ = value

    NA = 'NA'
    LOADED = 'LOADED'
    PENDING_EJECT = 'PENDING_EJECT'
    UNLOADING = 'UNLOADING'
    PENDING = 'PENDING'
    READY = 'READY'
    ERROR = 'ERROR'
    # DISMOUNTED

    @property # 7 Ranks
    def rank(self):
        ranks = {
            'ERROR': -3,
            'PENDING_EJECT': -2,
            'NA': -1,
            'PENDING': 0,
            'READY': 1,
            'LOADED': 2,
            'UNLOADING': 3,
        }
        return ranks.get(self._value_, 0)


class VerifyEnum(str, PyEnum):

    def __init__(self, value):
        self._value_ = value

    IN_PROGRESS = 'IN_PROGRESS'
    SUCCESS = 'SUCCESS'
    FAIL = 'FAIL'
    NA = 'NA'
    PENDING = 'PENDING'
    READY = 'READY'
    ERROR = 'ERROR'

    @property # 7 Ranks
    def rank(self):
        ranks = {
            'ERROR': -3,
            'FAIL': -2,
            'NA': -1,
            'PENDING': 0,
            'IN_PROGRESS': 1,
            'READY': 2,
            'SUCCESS': 3,
        }
        return ranks.get(self._value_, 0)


class PriorityEnum(str, PyEnum):

    def __init__(self, value):
        self._value_ = value

    LOW = 'LOW'
    NORMAL = 'NORMAL'
    HIGH = 'HIGH'
    # CRITICAL
    # URGENT

    @property # 3 Ranks
    def rank(self):
        ranks = {
            'HIGH': -1,
            'NORMAL': 0,
            'LOW': 1,
        }
        return ranks.get(self._value_, 0)


class Md5CompEnum(str, PyEnum):

    def __init__(self, value):
        self._value_ = value

    YES = 'YES'  # TRUE
    NO = 'NO'  # FALSE
    IN_PROGRESS = 'IN_PROGRESS'
    READY = 'READY'

    @property # 4 Ranks
    def rank(self):
        ranks = {
            'NO': -1,
            'READY': 0,
            'IN_PROGRESS': 1,
            'YES': 2,
        }
        return ranks.get(self._value_, 0)


class CharacterCheckEnum(str, PyEnum):

    def __init__(self, value):
        self._value_ = value

    NO = 'NO'  # NULL
    PASS = 'PASS'  # TRUE
    FAIL = 'FAIL'  # FALSE

    @property # 3 Ranks
    def rank(self):
        ranks = {
            'FAIL': -1,
            'NO': 0,
            'PASS': 1,
        }
        return ranks.get(self._value_, 0)