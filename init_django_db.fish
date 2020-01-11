function init_django_db
  set user $argv[1]
  set dbname $argv[2]
  dropdb $dbname
  dropuser $user
  createdb $dbname
  createuser --createdb $user
  psql -d $dbname -c "GRANT ALL PRIVILEGES ON DATABASE $dbname to $user;"
end
