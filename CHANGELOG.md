# CHANGELOG for onddo-spamassassin

This file is used to list changes made in each version of `onddo-spamassassin`.

## 0.2.0 (2014-09-22)

* `Gemfile` updates:
 * Berkshelf version 3.
 * Specify vagrant version.
 * Improved, added groups.
* `README` & metadata: `trusted_networks` default value fixed.
* `README`:
 * Added cookbook badge.
 * File separated in multiple files.
 * Added travis-ci and gamnasium badges.
* Fix SpamAssassin daemon with systemd: fixes Fedora support.
* *test/kitchen/cookbooks* directory moved to *test/cookbooks*.
* Added Fedora and Amazon Linux support.
* Added RedHat support.
* `kitchen.yml` file updated.
* Added `kitchen.cloud.yml` file
* `Berksfile`: use source instead of site.
* Added ChefSpec tests.
* Added `travis.yml` file and a `Rakefile`.
* `TODO` added tasks: *RuboCop* and namespace change.

## 0.1.0 (2013-06-09)

* Initial release of `onddo-spamassassin`.
