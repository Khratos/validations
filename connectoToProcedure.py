import pyodbc
import pandas as pd
import datetime as d
import cx_Oracle
import config as cfg

# conn = pyodbc.connect('Driver={Devart ODBC Driver for Oracle};'
#                   'Server=localhost;'
#                   'Database=XEPDB1;'
#                   'UID=SYSTEM;'
#                   'PWD=admin;')


# define parameters to be passed in and out
#quarter_date = d.date(year=2020, month=10, day=1)
#SQL = r'exec TERRITORIES_SP @quarterStart = ' + "'" + str(quarter_date) + "'"

#conn_str = 'SYSTEM/admin@localhost:1521/XEPDB1'
#conn = cx_Oracle.connect(conn_str)
"""
    BEGIN
      PDBADMIN.TO_CALL();
    END;
"""


try:
        # create a connection to the Oracle Database
        with cx_Oracle.connect(cfg.username,
                            cfg.password,
                            cfg.dsn,
                            encoding=cfg.encoding) as connection:
            # create a new cursor
            with connection.cursor() as cursor:
                # create a new variable to hold the value of the
                # OUT parameter
                #order_count = cursor.var(int)
                # call the stored procedure
                #myvar = cursor.var(int)
                myvar = ('0',)
                res = cursor.callproc('PDBADMIN.TO_CALL',myvar)
                print(myvar)
                print(res)
               
                # cursor.execute("BEGIN PDBADMIN.TO_CALL(); END;")
                # res = cursor.fetchall()
                # for row in res:
                #     print(res)
                
except cx_Oracle.Error as error:
        print(error)

# SQL = 'BEGIN PDBADMIN.TO_CALL(); END;'
# print(SQL)
# try:
#     print("try")
#     cursor = conn.cursor()
#     cursor.execute(SQL)
#     cursor.close()
#     conn.commit()
# except cx_Oracle.Error as error:
#         print(error)
# finally:
#     conn.close()