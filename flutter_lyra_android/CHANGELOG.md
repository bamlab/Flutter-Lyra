# 0.5.0

- **BREAKING CHANGE**: [iOS] Minimum iOS deployment target increased from 11.0 to 15.1
- **FEAT**: [Android] Update LyraPaymentSDK from ~1.5.7 to ~1.10.0
- **FIX**: [iOS] Update LyraPaymentSDK from ~2.7.7 to ~2.8.0 to fix iOS SDK 18.5 compatibility issues
- **FIX**: [iOS] Resolve C++ static assertion failures with Sentry dependency by using LyraPaymentSDK 2.8.0+ which removes Sentry dependency

# 0.4.0

- [Android] Upgrade kotlin version
- [Android] Upgrade gradle
- [Android] Upgrade material
- [Android] Upgrade compileSdkVersion

# 0.3.1

- **FEAT**: Add apple pay merchant id.

# 0.3.0

- Update a dependency to the latest release.
- **FEAT**: implements Apple Pay.

# 0.2.0

- **BREAKING**: remove implementation of the cancelProcess method.
- **FEAT**: implement timeout property in the process method.
- **FIX**: parse error with code instead of message after pigeon update.

# 0.1.2

- Add cancelProcess method

# 0.1.1

- Update packages Readme

# 0.1.0

- Initial release of this plugin.
