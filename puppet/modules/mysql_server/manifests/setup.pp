class mysql_server::setup inherits mysql_server {

  include mysql_server::package
  include mysql_server::config
  include mysql_server::service

}
