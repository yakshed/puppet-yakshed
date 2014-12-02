# == Class: yakshed::config
#
# Full description of class yakshed::config here
#
# === Parameters
#
# Document parameters here.
#
# [*parameter1*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*variable1*]
#   Explanation of how this variable affects the funtion of this class and
#   if it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames."
#
# === Examples
#
#  class { 'yakshed::config':
#    parameter1 => [ 'just', 'an', 'example', ]
#  }
#
# === Authors
#
# Sebastian Schulze <github.com@bascht.com> <github.com@bascht.com>
#
# === Copyright
#
# Copyright 2014 Sebastian Schulze <github.com@bascht.com>
#
class yakshed::config (
  $primary_user,
  $primary_user_ssh_key,
  $primary_user_ssh_key_type
){
  # Ensure we're not locking ourselves out
  ufw::allow { 'allow-ssh-eth0':
    port => 22,
    ip=> $ipaddress_eth0,
    proto => 'tcp',
  }

  user { $primary_user:
    ensure => present,
    managehome => true,
    groups  => ['sudo'],
    shell   => '/bin/zsh',
    password => ''
  }

  ssh_authorized_key { $primary_user:
    ensure => present,
    key    => $primary_user_ssh_key,
    type   => $primary_user_ssh_key_type,
    user   => $pri
  }

  class { 'locales':
    default_locale  => 'en_GB.UTF-8',
    locales         => ['en_US.UTF-8 UTF-8', 'en_GB.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8'],
  }

  package {'tzdata':
    ensure  => 'present'
  }

  file {'/etc/localtime':
    require => Package['tzdata'],
    source  => 'file:///usr/share/zoneinfo/Europe/Berlin'
  }

  file {'/etc/timezone':
    content => 'Europe/Berlin'
  }

  class { '::ntp':
    servers => [
      '0.pool.ntp.org',
      '1.pool.ntp.org',
      '2.pool.ntp.org',
      '3.pool.ntp.org',
    ],
  }

}
