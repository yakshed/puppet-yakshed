# == Define: yakshed::certificate
#
# Full description of defined resource type yakshed::certificate here
#
# === Parameters
#
# Document parameters here
#
# [*namevar*]
#   If there is a parameter that defaults to the value of the title string
#   when not explicitly set, you must always say so.  This parameter can be
#   referred to as a "namevar," since it's functionally equivalent to the
#   namevar of a core resource type.
#
# [*basedir*]
#   Description of this variable.  For example, "This parameter sets the
#   base directory for this resource type.  It should not contain a trailing
#   slash."
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   yakshed::certificate { 'namevar':
#     basedir => '/tmp/src',
#   }
#
# === Authors
#
# Sebastian Schulze <github.com@bascht.com> <github.com@bascht.com>
#
# === Copyright
#
# Copyright 2014 Sebastian Schulze <github.com@bascht.com>
#
define yakshed::certificate($key, $cert) {
  $files = {
    "/etc/ssl/certs/${name}.key" => { 'content'  => $key },
    "/etc/ssl/private/${name}.crt" => { 'content'  => $cert },
  }

  create_resources('file', $files)
}
