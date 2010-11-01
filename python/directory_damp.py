# Divides every frequency stored in half
# Credit to: http://matt.might.net/articles/console-hacks-exploiting-frequency/

from directory_recent import get_db_path, check_db_exists, get_cursor

def damp_db():
    file = get_db_path()
    check_db_exists(file)
    cursor = get_cursor(file)
    cursor.execute('UPDATE dircounts SET count = count / 2')

if __name__ == '__main__':
    damp_db()
