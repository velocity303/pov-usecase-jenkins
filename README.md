# POV Use Case for Jenkins Integration with Puppet Enterprise

## Overview

This profile will set up a Jenkins master server that has a job predefined to reach out to the POV master and do some basic validation based upon the Jenkinsfile that is within the built in control repo. The setup of this module should only require a proper hostname setting from the Jenkins server to the master so that the job can find the appropriate git repo.

## Installation

Use code manager to install this module by adding the following entry to your Puppetfile.

```
mod 'profile_jenkins',
  :git => 'https://github.com/velocity303/pov-usecase-jenkins.git'
```

## Modules Required

There are several modules required for this particular use case to function properly. Please add the following to your Puppetfile.

```
mod 'puppetlabs/stdlib', '4.13.1'
mod 'puppetlabs/apache', '1.11.0'
mod 'puppetlabs/firewall', '1.8.1'
mod 'puppetlabs/git', '0.5.0'
mod 'jenkins',
  :git => 'https://github.com/jenkinsci/puppet-jenkins.git',
  :ref => '1342f52be76206692e9b760f9437af35402e831e'

```

## Important variables

If looking to override the defaults provided by this profile, please use the following inserted into your hiera configuration.

```
---
profile_jenkins::master_hostname:  #string - Default: puppet
```

## Operating systems validated

This has currently been validated against CentOS/RedHat 7.2
