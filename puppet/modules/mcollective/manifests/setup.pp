class mcollective::setup inherits mcollective {

  include mcollective::config
  include mcollective::package
  include mcollective::service

}
