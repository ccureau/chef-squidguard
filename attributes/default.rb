# defaults
default['squidguard']['blacklist_date'] = Date.new()
default['squidguard']['update_days'] = 2

# Blacklist data to use.
# Choices are:  shallalist, toulouse
default['squidguard']['blacklist'] = 'shallalist'
default['squidguard']['filter'] = [ 'warez', 'porn' ]
default['squidguard']['filter_redirect'] = 'http://www.example.com/bad_url.html'

# Configure URL to get blacklist
case node['squidguard']['blacklist']

when 'shallalist'
  default['squidguard']['blacklist_name'] = 'shallalist.tar.gz'
  default['squidguard']['blacklist_url'] = "http://www.shallalist.de/Downloads"
  default['squidguard']['blacklist_unpack'] = "BL"
when 'toulouse'
  default['squidguard']['blacklist_name'] = 'blacklists.tar.gz'
  default['squidguard']['blacklist_url'] = "ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib"
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
