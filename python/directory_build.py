# Buils a database to store dir access commands.
# Credit to: http://matt.might.net/articles/console-hacks-exploiting-frequency/

from os import path
from directory_recent import get_db_path, get_cursor

def init_db():
    'Creates a db in memory with a table to save flights information'
    file = get_db_path()
    if path.isfile(file):
        raise Exception('database already exists')

    cursor = get_cursor(file)
    cursor.execute('''CREATE TABLE dircounts
                  (path VARCHAR(255) PRIMARY KEY NOT NULL,
                  count INT NOT NULL DEFAULT 0,
                  time DATE NOT NULL)''')

if __name__ == '__main__':
    init_db()
