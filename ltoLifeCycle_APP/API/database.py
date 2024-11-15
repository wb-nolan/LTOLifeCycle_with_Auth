from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


# DATABASE_URL = 'mysql+mysqlconnector://wbapps:pw4apps@alfred-01/alfred_mpi'
DEV_DATABASE_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/alfred_mpi'

engine = create_engine(DEV_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def alfred_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


LTO001_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/khlto_001'
LTO002_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/khlto_002'
LTO003_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/khlto_003'
LTO004_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/khlto_004'
LTO005_URL = 'mysql+pymysql://wbapps:pw4apps@localhost:3306/khlto_005'

# lto001_engine = create_engine(LTO001_URL)
# lto002_engine = create_engine(LTO002_URL)
# lto003_engine = create_engine(LTO003_URL)
# lto004_engine = create_engine(LTO004_URL)
# lto005_engine = create_engine(LTO005_URL)

# SessionLocalLTO001 = sessionmaker(
#     autocommit=False, autoflush=False, bind=lto001_engine)
# SessionLocalLTO002 = sessionmaker(
#     autocommit=False, autoflush=False, bind=lto002_engine)
# SessionLocalLTO003 = sessionmaker(
#     autocommit=False, autoflush=False, bind=lto003_engine)
# SessionLocalLTO004 = sessionmaker(
#     autocommit=False, autoflush=False, bind=lto004_engine)
# SessionLocalLTO005 = sessionmaker(
#     autocommit=False, autoflush=False, bind=lto005_engine)

db_session_factory = {
    'khlto-001': sessionmaker(autocommit=False, autoflush=False, bind=create_engine(LTO001_URL)),
    'khlto-002': sessionmaker(autocommit=False, autoflush=False, bind=create_engine(LTO002_URL)),
    'khlto-003': sessionmaker(autocommit=False, autoflush=False, bind=create_engine(LTO003_URL)),
    'khlto-004': sessionmaker(autocommit=False, autoflush=False, bind=create_engine(LTO004_URL)),
    'khlto-005': sessionmaker(autocommit=False, autoflush=False, bind=create_engine(LTO005_URL)),
}


def all_lto_db():
    for hostname, db_session in db_session_factory.items():
        session = db_session()
        try:
            yield hostname, session
        finally:
            session.close()


def lto_db(database):
    for hostname in db_session_factory.keys():
        if database == hostname:
            session = db_session_factory[database]
            try:
                yield session
            finally:
                session.close()
        else:
            raise ValueError(f"Unknown database hostname: {hostname}")

