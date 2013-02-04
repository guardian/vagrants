# Manage a Java installation
class java {

  # OpenJDK because Oracle does not allow repackaging the Oracle JDK into debs.
  package {
    'openjdk-6-jdk': ensure => present;
  }
}