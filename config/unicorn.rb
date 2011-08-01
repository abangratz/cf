worker_processes 3
working_directory "/var/www/rails/cf/current"
listen "unix:/var/www/rails/cf/shared/tmp/sockets/unicorn.sock"
pid "/var/www/rails/cf/current/tmp/pids/unicorn.pid"
