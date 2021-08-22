import pymysql
import os
from dotenv import load_dotenv, find_dotenv
from dbutils.persistent_db import PooledDB

# Load our environment variables from the .env file in the root of our project.
load_dotenv(find_dotenv())

# Set the variables in our application with those environment variables
host = os.environ.get("340DBHOST")
user = os.environ.get("340DBUSER")
passwd = os.environ.get("340DBPW")
db = os.environ.get("340DB")


def create_pool(host=host, user=user, passwd=passwd, db=db):
    """Return a database connection pool based on environment"""
    return PooledDB(
            creator=pymysql,
            host=host,
            user=user,
            password=passwd,
            database=db,
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor)


def execute_query(db_connection=None, query=None, query_params=()):
    """executes a given SQL query on the given db connection and returns a
    Cursor object.

    db_connection: a pymysql persistent connection object created by
    connect_to_database()
    query: string containing SQL query
    returns: A Cursor object as specified at
    https://www.python.org/dev/peps/pep-0249/#cursor-objects.
    You need to run .fetchall() or .fetchone() on that object to actually
    acccess the results.
    """

    if db_connection is None:
        print(
            "No connection to the database found! Have you called"
            + "connect_to_database() first?")
        return None

    if query is None or len(query.strip()) == 0:
        print("query is empty! Please pass a SQL query in query")
        return None

    print("Executing %s with %s" % (query, query_params))
    # Create a cursor to execute query. Why? Because apparently they optimize
    # execution by retaining a reference according to PEP0249
    cursor = db_connection.cursor(pymysql.cursors.DictCursor)

    # TODO: Sanitize the query before executing it!!!
    cursor.execute(query, query_params)
    # this will actually commit any changes to the database. without this no
    # changes will be committed!
    db_connection.commit()
    return cursor


if __name__ == '__main__':
    print("Library")
