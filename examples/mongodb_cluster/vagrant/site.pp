node default {
  include configuration

  # HACK: All nodes are going to try to initialise the replica set but only the
  # last up will actually be successful.
  include init-replica-set

  Class["configuration"] -> Class["init-replica-set"]
}