fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios carthage_bootstrap
```
fastlane ios carthage_bootstrap
```
Bootstrap Carthage
### ios cu
```
fastlane ios cu
```
Update Carthage
### ios carthage_update
```
fastlane ios carthage_update
```

### ios version
```
fastlane ios version
```
Create a new version
### ios test
```
fastlane ios test
```
Run unit tests

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
