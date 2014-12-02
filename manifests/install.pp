# == Class: yakshed::install
#
# Full description of class yakshed::install here
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
#  class { 'yakshed::install':
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
class yakshed::install (){

  apt::source { 'debian_wheezy':
    location          => 'http://debian.mirror.euserv.net',
    release           => 'wheezy',
    repos             => 'main contrib non-free',
    include_src       => true
  }

  apt::source { 'debian_wheezy_updates':
    location          => 'http://debian.mirror.euserv.net',
    release           => 'wheezy-updates',
    repos             => 'main contrib non-free',
    include_src       => true
  }

  apt::source { 'debian_wheezy_security':
    location          => 'http://security.debian.org',
    release           => 'wheezy/updates',
    repos             => 'main',
    include_src       => true
  }

  class { 'apt':
    purge_sources_list   => false,
    purge_sources_list_d => false
  }

  $base_packages = [
    'emacs23-nox',
    'rsync',
    'htop',
    'tmux',
    'zsh',
    'git',
    'unzip',
    'unattended-upgrades',
    'encfs'
  ]
  package { $base_packages:
    ensure => present
  }
}
