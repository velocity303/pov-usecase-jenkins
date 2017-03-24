class profile_jenkins {
  include git

  class { 'jenkins':
    version            => 'latest',
    lts                => true,
    configure_firewall => true,
  }

  # Disable Unlock Jenkins page
  file { '/var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion':
    ensure  => present,
    owner   => jenkins,
    group   => jenkins,
    mode    => '0644',
    content => '2.0',
    require => Class['jenkins']
  }

  package { 'puppet-lint':
    ensure       => present,
    provider => 'puppet_gem',
  }

  #  transition { 'create my groovy init script':
  #    resource   => File['/tmp/init.groovy'],
  #    attributes => {
  #      ensure  => present,
  #      content => 'def instance=jenkins.model.Jenkins.instance
  #      instance.setSlaveAgentPort(40196)
  #      instance.save()',
  #    },
  #    prior_to   => Exec['update jnlp port'],
  #  }

  #  exec { 'update jnlp port':
  #    command     => '/usr/bin/java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://127.0.0.1:8080 groovy /tmp/init.groovy',
  #    subscribe   => Class['jenkins'],
  #    refreshonly => true,
  #  }->

  file { '/tmp/init.groovy':
    ensure => absent,
  }

  #  jenkins::user { 'puppetpov':
  #    email    => 'puppetpov@localhost.localdomain',
  #    password => 'puppetlabs',
  #  }

  firewall { '001 allow jenkins-swarm through the firewall':
    pkttype => 'broadcast',
    proto   => udp,
    action  => accept,
  }

  firewall { '100 allow jenkins-swarm through the firewall':
    dport  => '40196',
    proto  => tcp,
    action => accept,
  }

  class { 'jenkins::master':
    version => '2.2',
  }

  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'gitlab-plugin': }
  jenkins::plugin { 'git': }
  jenkins::plugin { 'workflow-step-api': }
  jenkins::plugin { 'git-client': }
  jenkins::plugin { 'plain-credentials': }
  jenkins::plugin { 'structs': }
  jenkins::plugin { 'script-security': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-durable-task-step': }
  jenkins::plugin { 'workflow-scm-step': }
  jenkins::plugin { 'ssh-credentials': }
  jenkins::plugin { 'durable-task': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-support': }
  jenkins::plugin { 'scm-api': }
  jenkins::plugin { 'ace-editor': }
  jenkins::plugin { 'jquery-detached': }
  jenkins::plugin { 'mailer': }
  jenkins::plugin { 'matrix-project': }
  jenkins::plugin { 'display-url-api': }
  jenkins::plugin { 'junit': }
  jenkins::plugin { 'workflow-aggregator': }
  jenkins::plugin { 'pipeline-input-step': }
  jenkins::plugin { 'pipeline-milestone-step': }
  jenkins::plugin { 'pipeline-build-step': }
  jenkins::plugin { 'pipeline-stage-view': }
  jenkins::plugin { 'workflow-multibranch': }
  jenkins::plugin { 'pipeline-stage-step': }
  jenkins::plugin { 'workflow-cps-global-lib': }
  jenkins::plugin { 'workflow-job': }
  jenkins::plugin { 'momentjs': }
  jenkins::plugin { 'pipeline-rest-api': }
  jenkins::plugin { 'handlebars': }
  jenkins::plugin { 'cloudbees-folder': }
  jenkins::plugin { 'git-server': }
  jenkins::plugin { 'branch-api': }
  jenkins::plugin { 'pipeline-graph-analysis': }
  jenkins::plugin { 'credentials': 
    version => '2.1.11',
  }
  jenkins::plugin { 'pipeline-model-definition': }
  jenkins::plugin { 'credentials-binding': }
  jenkins::plugin { 'docker-workflow': }
  jenkins::plugin { 'pipeline-model-api': }
  jenkins::plugin { 'pipeline-model-extensions': }
  jenkins::plugin { 'pipeline-stage-tags-metadata': }
  jenkins::plugin { 'docker-commons': }
  jenkins::plugin { 'icon-shim': }
  jenkins::plugin { 'authentication-tokens': }
}
