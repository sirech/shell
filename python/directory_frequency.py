from directory_recent import get_db_path, check_db_exists, get_cursor, print_paths

def directory():
    file = get_db_path()
    check_db_exists(file)
    cursor = get_cursor(file)
    print_paths(cursor, '''SELECT path FROM dircounts ORDER BY count DESC LIMIT 7''')

if __name__ == '__main__':
    directory()
