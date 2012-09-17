define rabbitmq::add_user($u_password) {
  exec { "rabbitmq_create_${title}":
    unless  => "/usr/sbin/rabbitmqctl list_user_permissions ${title}",
    command => "/usr/sbin/rabbitmqctl add_user ${title} ${u_password}",
    require => Package['rabbitmq-server'],
    notify  => Exec["rabbitmq_set_access_${title}"],
  }

  exec { "rabbitmq_set_access_${title}":
    command     => "/usr/sbin/rabbitmqctl set_permissions -p / ${title} \".*\" \".*\" \".*\"",
    require     => Exec["rabbitmq_create_${title}"],
    refreshonly => true,
  }
}
