# linuxmint

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with linuxmint](#setup)
    * [What linuxmint affects](#what-linuxmint-affects)
    * [Beginning with linuxmint](#beginning-with-linuxmint)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The linuxmint module configures [Linux Mint](https://www.linuxmint.com/)
according to my own personal preferences.

## Setup

### What linuxmint affects

* Software centre configuration
* Cinnamon configuration
* Mint Welcome configuration

### Dependencies

This module has a dependency on
[puppet-gnome](https://github.com/ajxb/puppet-gnome) which is not available on
Puppet Forge so will need to be downloaded and installed using your preferred
method, e.g. [librarian-puppet](http://librarian-puppet.com/)

### Beginning with linuxmint

To configure Linux Mint using this module

```puppet
class { 'linuxmint':
  user  => 'auser',
  group => 'agroup',
}
```

## Usage

The default linuxmint class configures Linux Mint according to
[What linuxmint affects](#what-linuxmint-affects). To use default configuration:

```puppet
class { 'linuxmint':
  user  => 'auser',
  group => 'agroup',
}
```

## Reference

### Classes

#### Public classes

* `linuxmint`: Configures Linux Mint

#### Private classes

* `linuxmint::config::applets`: Handles the configuration of applets
* `linuxmint::config::cinnamon`: Handles the configuration of cinnamon
* `linuxmint::config::gsettings`: Handles applying all gsettings for module
* `linuxmint::config::lightdm`: Handles the configuration of lightdm
* `linuxmint::config::mintwelcome`: Handles the configuration of mint welcome
* `linuxmint::config::nemo`: Handles the configuration of nemo
* `linuxmint::config::software_centre`: Handles the configuration of software
centre
* `linuxmint::install::applets`: Handles the installation of applets
* `linuxmint::params`: Handles the module default parameters

### Parameters

The following parameters are available in the `linuxmint` class:

#### `user`

Data type: String.

The user to configure. Note this parameter is mandatory and should be passed to
the class on instantiation.

Default value: 'undef'.

#### `group`

Data type: String.

The group associated with the user. Note this parameter is mandatory and should
be passed to the class on instantiation.

Default value: 'undef'.

## Limitations

This module has only been tested against Linux Mint 18.3.  This module is
specific to Linux Mint only.

## Development

### Contributing

Before starting your work on this module, you should fork the project to your
GitHub account. This allows you to freely experiment with your changes. When
your changes are complete, submit a pull request. All pull requests will be
reviewed and merged if they suit some general guidelines:

* Changes are located in a topic branch
* For new functionality, proper tests are written
* Your change does not handle third party software for which dedicated Puppet
modules exist such as creating databases, installing webserver etc.
* Changes follow the recommended Puppet style guidelines from the
[Puppet Language Style Guide](https://docs.puppet.com/puppet/latest/style_guide.html)

### Branches

Choosing a proper name for a branch helps us identify its purpose and possibly
find an associated bug or feature. Generally a branch name should include a
topic such as `bug` or `feature` followed by a description and an issue number
if applicable. Branches should have only changes relevant to a specific issue.

```
git checkout -b bug/service-template-typo-1234
git checkout -b feature/config-handling-1235
```

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to
verify functionality. For detailed information on using this tool, please see
the relevant documentation.

#### Testing quickstart

```
gem install bundler
bundle install
rake spec
```
