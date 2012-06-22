node default {
  include guardian
  include java

  Class['guardian'] -> Class['java']
}