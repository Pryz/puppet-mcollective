class mcollective::agents inherits mcollective {

    file { '/usr/libexec/mcollective/mcollective/agent' :
        ensure  => directory,
        recurse => true,
        source  => 'puppet:///modules/mcoagents',
        owner   => 'root',
        group   => 'root',
        require => Package[ 'mcollective-common' ],
        notify  => Service[ 'mcollective' ],
    }

    package { 'mcollective-puppet-agent' :
        ensure  => present,
        require => [ Yumrepo[ 'kermit-thirdpart' ],
                     Package[ 'mcollective-common'], ],
    }

    package { 'mcollective-puppet-client' :
        ensure => $::hostname ? {
            $nocnode => present,
            default  => absent,
        },
        require => [ Yumrepo[ 'kermit-thirdpart' ],
                     Package[ 'mcollective-common' ], ],
    }

}
