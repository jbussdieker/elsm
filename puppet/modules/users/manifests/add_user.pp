define users::add_user($u_uid,$u_gid='',$u_hash='*',$u_authkey='',$u_groups='', $u_privkey='', $u_config='', $u_pubkey='', $u_shell='/bin/bash', $u_home=''){

  if $u_gid == '' {
    $the_gid = $u_uid
  }

  if $u_home == '' {
    $the_home = "/home/${name}"
  } else {
    $the_home = $u_home
  }

  if $u_groups == '' {
    $the_groups = $name
  } else {
    $the_groups = $u_groups
  }

  user { $name :
    ensure     => 'present',
    comment    => '',
    uid        => $u_uid,
    password   => $u_hash,
    home       => $the_home,
    gid        => $the_gid,
    groups     => $the_groups,
    shell      => $u_shell,
    managehome => true,
    require    => Group[$name],
  }

  group { $name :
    ensure => 'present',
    gid    => $the_gid,
  }


  file { "${the_home}/.ssh":
    ensure  => directory,
    owner   => $name,
    group   => $name,
    mode    => '0700',
    require => User[$name],
  }

  if $u_authkey != '' {
    file { "/home/${name}/.ssh/authorized_keys":
      ensure  => file,
      owner   => $name,
      group   => $name,
      mode    => '0600',
      source  => "puppet:///modules/users/auth_keys/${name}_auth",
      require => [User[$name],File["/home/${name}/.ssh"]],
    }
  }

  if $u_privkey != '' {
    file { "/home/${name}/.ssh/id_rsa":
      ensure  => file,
      owner   => $name,
      group   => $name,
      mode    => '0600',
      source  => "puppet:///modules/users/auth_keys/${name}_id",
      require => [User[$name],File["/home/${name}/.ssh"]],
    }
  }

  if $u_pubkey != '' {
    file { "/home/${name}/.ssh/id_rsa.pub":
      ensure  => file,
      owner   => $name,
      group   => $name,
      mode    => '0644',
      source  => "puppet:///modules/users/auth_keys/${name}_id.pub",
      require => [User[$name],File["/home/${name}/.ssh"]],
    }
  }

  if $u_config != '' {
    file { "/home/${name}/.ssh/config":
      ensure  => file,
      owner   => $name,
      group   => $name,
      mode    => '0644',
      source  => "puppet:///modules/users/auth_keys/${name}_config",
      require => [User[$name],File["/home/${name}/.ssh"]],
    }
  }

}
