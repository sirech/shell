# Logs an access to the current directory to a database.
# Credit to: http://matt.might.net/articles/console-hacks-exploiting-frequency/

from os import environ
from directory_recent import get_db_path, check_db_exists, get_cursor

def log_to_db():
    'Creates a db in memory with a table to save flights information'
    file = get_db_path()
    check_db_exists(file)
    cursor = get_cursor(file)

    current = "'" + environ['PWD'] + "'"
    query = '''INSERT OR IGNORE INTO dircounts(path,count, time) VALUES (%s,1, DATETIME('NOW'));
               UPDATE dircounts SET count = count + 1, time = DATETIME('NOW') WHERE path like %s;''' % (current, current)

    cursor.executescript(query)

if __name__ == '__main__':
    log_to_db()
