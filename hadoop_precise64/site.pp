node default {
  include hadoop
  include pig
  include hive
  include flume
  include r

  Class["hadoop"] -> Class["pig"]
  Class["hadoop"] -> Class["hive"]
  Class["hadoop"] -> Class["flume"]
}