fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios documentation

```sh
[bundle exec] fastlane ios documentation
```

Generate documentation

### ios lint

```sh
[bundle exec] fastlane ios lint
```

Run SwiftLint

### ios test

```sh
[bundle exec] fastlane ios test
```

Run unit tests

### ios ensure_release_ready

```sh
[bundle exec] fastlane ios ensure_release_ready
```

Ensure that the repo is valid for release

### ios version

```sh
[bundle exec] fastlane ios version
```

Create a new version

### ios docc

```sh
[bundle exec] fastlane ios docc
```

Build documentation for all platforms

### ios docc_platform

```sh
[bundle exec] fastlane ios docc_platform
```

Build documentation for a single platform

### ios docc_delete_derived_data

```sh
[bundle exec] fastlane ios docc_delete_derived_data
```

Delete documentation derived data (may be historic duplicates)

### ios docc_web

```sh
[bundle exec] fastlane ios docc_web
```

Build static documentation websites for all platforms

### ios docc_web_platform

```sh
[bundle exec] fastlane ios docc_web_platform
```

Build static documentation website for a single platform

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
