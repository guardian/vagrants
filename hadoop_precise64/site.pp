node default {
  include hadoop
  include pig
  include hive

  Class["hadoop"] -> Class["pig"]
  Class["hadoop"] -> Class["hive"]
}