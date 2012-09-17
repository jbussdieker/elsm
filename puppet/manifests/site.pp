node default {
  include apt::setup
  include sudoers::setup

  if $ec2_security_groups == "master" {
    include master::setup
  } elsif $ec2_security_groups == "app" {
    include app::setup
  }
}
