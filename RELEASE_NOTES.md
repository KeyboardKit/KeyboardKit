# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

### 💡 Adjustments

* `AutocompleteProvider` is now async instead of using completions.

### 👑 Pro Adjustments

* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.
    
### 💥 Breaking changes 

* All deprecated code has been removed or addressed.
* `EnglishCalloutActionProvider` has been removed.
* `StandardCalloutActionProvider.standardProvider` has been removed.
