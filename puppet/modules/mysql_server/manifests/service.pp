class mysql_server::service inherits mysql_server {

  monit::create_simple { 'mysql': 
    pid_file => '/run/mysqld/mysqld.pid',
    cmd_name => 'mysql',
    group    => 'mysql',
  }

  service { 'mysql':
    ensure => running,
  }

}
