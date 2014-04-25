class virtualbox::darwin {
  exec { 'Kill Virtual Box Processes':
    command     => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }

  package { 'VirtualBox-4.3.4-91027-OSX.dmg':
    ensure   => installed,
    provider => 'pkgdmg',
    source   => 'http://download.virtualbox.org/virtualbox/4.3.4/VirtualBox-4.3.4-91027-OSX.dmg',
    require  => Exec['Kill Virtual Box Processes'],
  }
}

class vagrant::darwin {
  package { 'Vagrant-1.4.0.dmg':
    ensure   => installed,
    source   => 'https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.0.dmg',
    provider => 'pkgdmg'
  }
}

class serf::darwin {
# Linux     https://dl.bintray.com/mitchellh/serf/0.3.0_linux_386.zip
# MacOSX    https://dl.bintray.com/mitchellh/serf/0.3.0_darwin_386.zip
}

case $operatingsystem {
  'Darwin': {
    include virtualbox::darwin
    include vagrant::darwin
  }
  'CentOS': {
  }
}
