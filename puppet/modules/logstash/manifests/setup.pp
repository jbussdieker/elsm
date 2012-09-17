class logstash::setup inherits logstash {

  include monit::setup

  include logstash::package
  include logstash::service
  include logstash::config

}
