# == Class: openstack_extras::auth_file
#
# Creates an auth file that can be used to export
# environment variables that can be used to authenticate
# against a keystone server.
#
# === Parameters
#
# [*password*]
#   (required) Password for this account as defined in keystone
#
# [*auth_url*]
#   (optional) URL to authenticate against
#   Defaults to 'http://127.0.0.1:5000/v3/'
#
# [*service_token*]
#   (optional) Keystone service token
#   NOTE: This setting will trigger a warning from keystone.
#   Authentication credentials will be ignored by keystone client
#   in favor of token authentication.
#   Defaults to undef.
#
# [*service_endpoint*]
#   (optional) Keystone service endpoint
#   Defaults to 'http://127.0.0.1:35357/v3/'
#
# [*username*]
#   (optional) Username for this account as defined in keystone
#   Defaults to 'admin'.
#
# [*tenant_name*]
#   (optional) Tenant for this account as defined in keystone
#   Defaults to undef.
#
# [*project_name*]
#   (optional) Project for this account as defined in keystone
#   Use instead of tenant_name for when using identity v3.
#   Defaults to 'openstack'.
#
# [*region_name*]
#   (optional) Openstack region to use
#   Defaults to 'RegionOne'.
#
# [*use_no_cache*]
#   (optional) Do not use the auth token cache.
#   Defaults to true.
#
# [*cinder_endpoint_type*]
#   (optional) The Cinder endpoint to use
#   Defaults to 'publicURL'.
#
# [*glance_endpoint_type*]
#   (optional) The Glance endpoint to use
#   Defaults to 'publicURL'.
#
# [*keystone_endpoint_type*]
#   (optional) The Keystone endpoint to use
#   Defaults to 'publicURL'.
#
# [*nova_endpoint_type*]
#   (optional) The Nova endpoint to use
#   Defaults to 'publicURL'.
#
# [*neutron_endpoint_type*]
#   (optional) The Neutron endpoint to use
#   Defaults to 'publicURL'.
#
# [*auth_strategy*]
#   (optional) The method to use for authentication
#   Defaults to 'keystone'.
#
# [*path*]
#   (optional) File path
#   Defaults to '/root/openrc'.
#
# [*project_domain*]
#   (optional) Project domain in v3 api.
#   Defaults to 'default'.
#
# [*user_domain*]
#   (optional) User domain in v3 api.
#   Defaults to 'default'.
#
# [*identity_api_version*]
#   (optional) Identity API version to use.
#   Defaults to '3'.
#

class openstack_extras::auth_file(
  $password                 = undef,
  $auth_url                 = 'http://127.0.0.1:5000/v3/',
  $service_token            = undef,
  $service_endpoint         = 'http://127.0.0.1:35357/v3/',
  $username                 = 'admin',
  $tenant_name              = undef,
  $project_name             = 'openstack',
  $region_name              = 'RegionOne',
  $use_no_cache             = true,
  $project_domain           = 'default',
  $user_domain              = 'default',
  $cinder_endpoint_type     = 'publicURL',
  $glance_endpoint_type     = 'publicURL',
  $keystone_endpoint_type   = 'publicURL',
  $nova_endpoint_type       = 'publicURL',
  $neutron_endpoint_type    = 'publicURL',
  $auth_strategy            = 'keystone',
  $path                     = '/root/openrc',
  $identity_api_version     = '3',
) {
  if ! $password {
    fail('You must specify a password for openstack_extras::auth_file')
  }
  file { $path:
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    content => template('openstack_extras/openrc.erb')
  }
}
