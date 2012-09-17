class collectd::setup inherits collectd {

  include collectd::package
  include collectd::service
  include collectd::config

}
