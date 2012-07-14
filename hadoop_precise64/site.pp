node default {
  include hadoop
  include pig
  include hive
  include flume

  Class["hadoop"] -> Class["pig"]
  Class["hadoop"] -> Class["hive"]
  Class["hadoop"] -> Class["flume"]
}