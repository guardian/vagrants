class guardian {

  include base-installation
  include apt
  include standard-packages

  Class["apt"] -> Class["standard-packages"]
}