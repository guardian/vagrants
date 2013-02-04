node default {
  stage { 'preinstall': } -> Stage[main]

  class {
    'guardian': stage => 'preinstall'
  }

  include $hostname
}
