# == Class: nagios::debian
#
# Define common resources specific to debian based systems. It shouldn't be
# necessary to include this class directly. Instead, you should use:
#
#   include nagios
#
class nagios::debian inherits nagios::base {

  include ::nagios::params

  # Common resources between base, redhat, and debian

  package {[
    'nagios3-common',
    'nagios-plugins',
    'nagios-plugins-standard',
    'nagios-plugins-basic',
    ]:
    ensure => installed,
  }
  package {'nagios':
    ensure => installed,
    name   => 'nagios3-core',
  }

  Service['nagios'] {
    name => 'nagios3',
  }

  File['/var/lib/nagios3'] {
    mode => '0751',
  }


  # debian specific resources below
  $niceness = $nagios::niceness

  file {'/etc/default/nagios3':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('nagios/etc/default/nagios3.erb'),
    require => Package['nagios'],
  }

}
