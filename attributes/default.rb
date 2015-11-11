# defaults
default['squidguard']['blacklist_cksum'] = ''

# Blacklist data to use.
# Choices are:  shallalist, mesd, toulouse
default['squidguard']['blacklist'] = 'shallalist'
default['squidguard']['filter'] = [ 'warez', 'porn' ]
default['squidguard']['filter_redirect'] = 'http://www.example.com/bad_url.html'

# Configure URL to get blacklist
case node['squidguard']['blacklist']

when 'shallalist'
  default['squidguard']['blacklist_name'] = 'shallalist.tar.gz'
  default['squidguard']['blacklist_url'] = "http://www.shallalist.de/Downloads/#{node['squidguard']['blacklist_name']}"
  default['squidguard']['blacklist_unpack'] = "BL"
when 'mesd'
  default['squidguard']['blacklist_name'] = 'blacklists.tgz'
  default['squidguard']['blacklist_url'] = "http://squidguard.mesd.k12.or.us/#{node['squidguard']['blacklist_name']}"
  default['squidguard']['blacklist_unpack'] = "blacklists"
when 'toulouse'
  default['squidguard']['blacklist_name'] = 'blacklists.tar.gz'
  default['squidguard']['blacklist_url'] = "ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/#{node['squidguard']['blacklist_name']}"
  default['squidguard']['blacklist_unpack'] = "blacklists"

end

# system-specific defaults
case platform_family

when 'debian'
  default['squidguard']['package'] = 'squidguard'
  default['squidguard']['config_dir'] = '/etc/squidguard'
  default['squidguard']['config_file'] = '/etc/squidguard/squidGuard.conf'
  default['squidguard']['db_dir'] = '/var/lib/squidguard/db'
  default['squidguard']['log_dir'] = '/var/log/squidguard'
  default['squidguard']['user'] = 'proxy'
  default['squidguard']['group'] = 'proxy'
  default['squidguard']['version'] = '1.5' if node['platform_version'] =~ /8\./

end
