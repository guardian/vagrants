node default {
  include hadoop
  include pig

  Class["hadoop"] -> Class["pig"]
}