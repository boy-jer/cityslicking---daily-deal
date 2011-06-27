# Finalize data models and connect to database

  DataMapper.finalize
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data/development.sqlite3")
