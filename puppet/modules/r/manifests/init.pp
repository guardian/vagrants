class r {

  include guardian
  include cran-repository

  package { "r-base": ensure => latest; }

  Class["guardian"] ->
    Class["cran-repository"] ->
    Package["r-base"]
}