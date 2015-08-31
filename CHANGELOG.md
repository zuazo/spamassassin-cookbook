# CHANGELOG for onddo-spamassassin

This file is used to list changes made in each version of `onddo-spamassassin`.

## v1.1.0 (2015-08-31)

* Add Oracle Linux support.
* Install `deltarpm` package on Fedora.
* metadata: Add `source_url` and `issues_url`.
* Update contact information and links after migration.

* Documentation:
 * README:
  * Use markdown tables.
  * Improve description.

* Testing:
 * Gemfile: Update RuboCop to `0.33.0`.
 * Add a *Vagrantfile*.
 * Add a *Guardfile*.
 * Add a *.rubocop.yml* file.
 * Move ChefSpec tests to *test/unit*.
 * Rakefile: Add clean task.
 * .kitchen.yml: Update platforms.
 * Travis CI:
  * Add Ruby `2.2`.
  * Run test-kitchen in Travis with the `kitchen-in-travis` script.

## v1.0.0 (2015-04-29)

* Move the attribute namespace from `node['onddo-spamassassin']` to `node['spamassassin']`, includes a deprecation message  (**breaking change**).
* Add SUSE and OpenSUSE support.
* Refactor and improve multiple platform support.
* Fix all RuboCop offenses.

* Tests
 * Add ServerSpec integration tests.
 * Integrate unit tests with `should_not` gem.
 * Update unit tests to use `ChefSpec::SoloRunner`.
 * travis.yml: Use the new build env.

## v0.2.0 (2014-09-22)

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

## v0.1.0 (2013-06-09)

* Initial release of `onddo-spamassassin`.
