# Get apache up and running

class apache {
    case $operatingsystem {
        centos: {
            package { "httpd-devel": 
                ensure => present,
                before => File['/etc/httpd/conf.d/playdoh-site.conf']; 
            }
            file { "/etc/httpd/conf.d/playdoh-site.conf":
                source  => "$PROJ_DIR/puppet/files/etc/httpd/conf.d/playdoh-site.conf",
                owner   => "root", group => "root", mode => 0644,
                require => [ Package['httpd-devel'] ];
            }
            service { "httpd":
                ensure    => running,
                enable    => true,
                require   => [
                    Package['httpd-devel'],
                    File['/etc/httpd/conf.d/playdoh-site.conf']
                ]
                #subscribe => File['/etc/httpd/conf.d/playdoh-site.conf']
            }

        }
        ubuntu: {
            package { "apache2-dev": 
                ensure => present,
                before => File['/etc/apache2/sites-enabled/playdoh-site.conf']; 
            }
            file { "/etc/apache2/sites-enabled/playdoh-site.conf":
                source  => "$PROJ_DIR/puppet/files/etc/httpd/conf.d/playdoh-site.conf",
                owner   => "root", group => "root", mode => 0644,
                require => [ Package['apache2-dev'] ];
            }
            service { "apache2":
                ensure    => running,
                enable    => true,
                require   => [
                    Package['apache2-dev'],
                    File['/etc/apache2/sites-enabled/playdoh-site.conf']
                ]
                #subscribe => File['/etc/apache2/sites-enabled/playdoh-site.conf']
            }
        }
    }
}
