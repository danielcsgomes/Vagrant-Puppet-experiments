class yum_update {

    exec { "yum-priorities":
        command => "sudo yum install -y yum-priorities",
        path => ["/usr/bin"]
    }

    file { "repositories":
        path => '/etc/yum.repos.d/custom.repo',
        ensure => file,
        content => template('repos/custom.repo'),
        require => Exec["yum-priorities"],
    }

    exec { "yum-update":
        command => "sudo yum -y update",
        path => ["/usr/bin"],
    }
}

class tools {
    package { "git":
        ensure => latest,
        require => Exec["yum-update"],
    }
    package { "curl":
        ensure => present,
        require => Exec["yum-update"],
    }
    package { "wget":
        ensure => present,
        require => Exec["yum-update"],
    }
    package { "vim-enhanced":
        ensure => latest,
        require => Exec["yum-update"],
    }

    exec { "alias-vim":
        command => "echo \"alias vi=vim\" >>  ~/.bashrc",
        path => ["/bin"],
        require => Package["vim-enhanced"],
    }
}

class httpd {

    package { "httpd":
        ensure => latest,
    }
}

class nginx {

    package { "nginx":
        ensure => latest,
    }
}

class php {

    package { "php":
        ensure => "5.3.18-1.el6.remi"
    }
    package { "php-cli":
        ensure => "5.3.18-1.el6.remi"
    }
    package { "php-common":
        ensure => "5.3.18-1.el6.remi"
    }
}

include yum_update
include tools
include httpd
include nginx
include php