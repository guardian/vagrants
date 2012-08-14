node default {
  include guardian
  include boxgrinder

  Class['guardian'] -> Class['boxgrinder']
}