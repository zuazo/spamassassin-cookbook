# Change Log
All notable changes to the `onddo-spamassassin` cookbook will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.0.0] - 2017-03-12
### Added
- Metadata: Add `chef_version`.
- Metadata: Remove grouping ([RFC-85](https://github.com/chef/chef-rfc/blob/8d47f1d0afa5a2313ed2010e0eda318edc28ba47/rfc085-remove-unused-metadata.md)).
- Add documentation for libraries.

### Changed
- Prepare for Chef 13.
- README: Add badges: docu, github, license, code climate, coveralls, inch-ci.
- CHANGELOG: Follow "Keep a CHANGELOG".
- Update RuboCop to `0.47` and fix new offenses.

### Removed
- Drop Ruby `< 2.2` support.
- Drop Chef `< 12` support.

## [1.1.0] - 2015-08-31
### Added
- Add Oracle Linux support.
- Install `deltarpm` package on Fedora.
- metadata: Add `source_url` and `issues_url`.

### Changed
- Update contact information and links after migration.
- README: Use markdown tables and improve description.

## [1.0.0] - 2015-04-29
### Added
- Add SUSE and OpenSUSE support.

### Changed
- Move the attribute namespace from `node['onddo-spamassassin']` to `node['spamassassin']`, includes a deprecation message  (**breaking change**).
- Refactor and improve multiple platform support.

### Fixed
- Fix all RuboCop offenses.

## [0.2.0] - 2014-09-22
### Added
- Add Fedora and Amazon Linux support.
- Add RedHat support.
- `README`:
  - Added cookbook badge.
  - File separated in multiple files.
  - Added travis-ci and gamnasium badges.

### Fixed
- `README` & metadata: `trusted_networks` default value fixed.
- Fix SpamAssassin daemon with systemd: fixes Fedora support.

## 0.1.0 - 2013-06-09
- Initial release of `onddo-spamassassin`.

[Unreleased]: https://github.com/zuazo/spamassassin-cookbook/compare/2.0.0...HEAD
[2.0.0]: https://github.com/zuazo/spamassassin-cookbook/compare/1.1.0...2.0.0
[1.1.0]: https://github.com/zuazo/spamassassin-cookbook/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/zuazo/spamassassin-cookbook/compare/0.2.0...1.0.0
[0.2.0]: https://github.com/zuazo/spamassassin-cookbook/compare/0.1.0...0.2.0
