class logstash {
  if $logstash_version {
    $u_logstash_version = $logstash_version
  } else {
    $u_logstash_version = '1.1.1'
  }
}
