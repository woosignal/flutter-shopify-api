## [2.4.2] - 2026-09-12

### Changed
- Debug logging (`debugMode: true`) now uses `debugPrint` instead of `print`.
- Switched the analyzer config from `package:lints/recommended.yaml` to the `vibe_check` Nylo preset and added `vibe_check` `^1.0.1` as a dev dependency.
- Migrated the test suite from `package:test` to `flutter_test` and removed the `test` dev dependency, which could not resolve alongside `flutter_test` and `vibe_check`.
- Added explicit type annotations flagged by the `specify_nonobvious_*` lint rules.

### Fixed
- `getProduct()` no longer prints the raw JSON response to the console on every call, even with `debugMode` off.

## [2.4.1] - 2026-09-07

### Changed
- Bumped `dio` to `^5.11.1`, `nylo_support` to `^7.29.0`, `device_meta` to `^3.0.4`, `intl` to `^0.20.3`, `test` to `^1.31.1`.
- Excluded generated `build/**` directories (and `android/**`, `ios/**` in the example) from analyzer checks.

## [2.4.0] - 2026-05-25

### Added
- Test-only `dio` getter on `WooSignalShopify` for HTTP mocking via `@visibleForTesting`.
- `http_mock_adapter` dev dependency and rewritten test suite that mocks all endpoints.
- Rewritten example app: API explorer with grouped endpoints, request log, customer session persistence, and `--dart-define=WOOSIGNAL_KEY` config.

### Changed
- Upgraded `nylo_support` from `^6.38.1` to `^7.27.0` (major).
- Upgraded `device_meta` from `^2.1.10` to `^3.0.2` (major).
- Bumped `dio` to `^5.9.2`, `lints` to `^6.1.0`, `test` to `^1.31.0`.
- Updated copyright year to 2026.

### Fixed
- `setDeviceMeta()` no longer calls `DeviceMeta.init()` on web platforms before the platform check, avoiding unnecessary work and potential errors.

## [2.3.3] - 2025-12-13

* pubspec.yaml updates

## [2.3.2] - 2025-09-06

* pubspec.yaml updates

## [2.3.1] - 2025-07-17

* pubspec.yaml updates

## [2.3.0] - 2025-05-23

* Add money formatter into the library

## [2.2.5] - 2025-05-23

* pubspec.yaml updates

## [2.2.4] - 2025-03-27

* pubspec.yaml updates

## [2.2.3] - 2025-02-27

* pubspec.yaml updates

## [2.2.2] - 2025-02-07

* pubspec.yaml updates

## [2.2.1] - 2025-01-05

* pubspec.yaml updates

## [2.2.0] - 2024-12-31

* Breaking change: Update ids to use String
* Update readme
* Update copyright year
* pubspec.yaml updates

## [2.1.0] - 2024-12-16

* pubspec.yaml updates

## [2.0.1] - 2024-12-06

* pubspec.yaml updates

## [2.0.0] - 2024-11-29

* pubspec.yaml updates

## [1.3.12] - 2024-07-15

* pubspec.yaml updates

## [1.3.11] - 2024-07-08

* pubspec.yaml updates

## [1.3.10] - 2024-06-25

* pubspec.yaml updates

## [1.3.9] - 2024-06-15

* pubspec.yaml updates

## [1.3.8] - 2024-05-14

* pubspec.yaml updates

## [1.3.7] - 2024-05-08

* pubspec.yaml updates

## [1.3.6] - 2024-05-02

* pubspec.yaml updates

## [1.3.5] - 2024-04-27

* pubspec.yaml updates

## [1.3.4] - 2024-04-23

* pubspec.yaml updates

## [1.3.3] - 2024-04-09

* pubspec.yaml updates

## [1.3.2] - 2024-04-02

* pubspec.yaml updates

## [1.3.1] - 2024-03-28

* pubspec.yaml updates

## [1.3.0] - 2024-03-27

* Fix `get` http method not setting data
* Added `authUserAccessToken()` to get the users access token
* Added `authUserId()` to get the users id
* Added `authUser()` to get the logged in user
* Added `authUserLoggedIn()` to check if a user is logged in
* Added `authShopifyUserModel()` to login a user
* Added `authLogout()` to logout a user
* Added `authLogin()` to login a user
* pubspec.yaml updates

## [1.2.2] - 2024-03-23

* pubspec.yaml updates

## [1.2.1] - 2024-03-20

* pubspec.yaml updates

## [1.2.0] - 2024-03-11

* Ability to set the Shopify customer id from the `WooSignalShopify` class
* pubspec.yaml updates

## [1.1.3] - 2024-03-07

* pubspec.yaml updates

## [1.1.2] - 2024-02-28

* pubspec.yaml updates

## [1.1.1] - 2024-02-25

* Fix `fetchShippingZones` method
* pubspec.yaml updates

## [1.1.0] - 2024-02-21

* New method to get collections by ids `getCollectionsByIds`
* Refactor ProductSearch model

## [1.0.7] - 2024-02-17

* Update `_setDioHeaders` method in Api Provider
* Refactor Imports
* Add `support_email` to WooSignalApp

## [1.0.6] - 2024-02-15

* Fix `getProductsRestApi` method

## [1.0.5] - 2024-02-14

* Update README
* pubspec.yaml updates

## [1.0.4] - 2024-02-14

* pubspec.yaml updates

## [1.0.3] - 2024-02-13

* Updated README.md

## [1.0.2] - 2024-02-10

* Updated README.md

## [1.0.1] - 2024-02-10

* Updated README.md

## [1.0.0] - 2024-02-10

* Initial Release