from sqlite3 import connect
from os import path, environ

def get_db_path():
    return path.expanduser('~/.dirlogsdb')

def check_db_exists(file):
    if not path.isfile(file) :
        raise Exception('database does not exist')

def get_cursor(file):
    return connect(file).cursor()

def print_paths(cursor, query):
    home = environ['HOME']

    cursor.execute(query)
    for row in cursor:
        print row[0].replace(home, '~')

def directory():

    file = get_db_path()
    check_db_exists(file)
    cursor = get_cursor(file)
    print_paths(cursor, '''SELECT path FROM dircounts ORDER BY time DESC LIMIT 7''')

if __name__ == '__main__':
    directory()
