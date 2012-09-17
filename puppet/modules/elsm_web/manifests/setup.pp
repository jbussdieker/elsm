class elsm_web::setup inherits elsm_web {

  include git::setup

  include elsm_web::package
  include elsm_web::service
  include elsm_web::config

}
