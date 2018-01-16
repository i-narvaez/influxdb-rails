# Changelog

For the full commit log, [see here](https://github.com/influxdata/influxdb-rails/commits/master).


## Unreleased changes

- None.

## v0.4.3, released 2017-12-12

- Added `time_precision` config option (#42, @kkentzo)

## v0.4.2, released 2017-11-28

- Added `open_timeout`, `read_timeout`, and `max_delay` config options
  (#41, @emaxi)
- Deprecate unused method (`#reraise_global_exceptions` in
  `InfluxDB::Rails::Configuration`, #37, @vassilevsky)

## v0.4.1, released 2017-10-23

- Bump `influx` version dependency (#40, @rockclimber73)

## v0.4.0, released 2017-08-19

- Drop support for Rails 3, Ruby < 2.2
- Sync version with `influxdb` gem

## v0.1.12, released 2017-06-06

- Added Rails 5.1 compatibility (#31, @djgould).
- Added `retry` config option (#17, @scambra and #18, @bcantin).

## v0.1.11, released 2016-11-24

- Bumped `influxdb` Rubygem dependency (#28, #32, @agx).

**Note:** The real changelog starts here. Previous entries are reconstructed
from the commit history by correlating release version with Git tags, which
may or may not reflect what was really released.

## v0.1.10, released 2014-10-08

- Lazy loading of `InfluxDB::Client` (#15, @chingo13).
- Various test fixes.

## v0.1.9, released 2014-06-18

- v0.1.8 was yanked
- Initializer now allows multiple hosts.

## v0.1.7, released 2014-04-09

- Added logger.

## v0.1.6, released 2014-04-08

- No changes (?)

## v0.1.5, released 2014-04-02

- No changes (?)

## v0.1.4, released 2014-03-26

- Added docs
- Made `async` option default to `true`.

## v0.1.3, released 2014-02-11

- Set series name defaults.
- Fixed a configuration bug.

## v0.1.2, released 2014-02-11

- Graceful handling of authentication errors.
- Fixes in documentation.

## v0.1.1, released 2014-02-06

- Refactoring of `ActiveSupport::Notification` handling.
- Added more initializer options.

## v0.1.0, released 2014-02-06

- Larger refactoring.
