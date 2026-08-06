# Changelog

All notable changes to `syzygy-foundation-ios` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.0.0] - 2026-08-06

### Added

#### Primitives
- `SyzygyID<T>` — phantom-typed UUID-backed identifier; `Comparable`, `Codable`, `Sendable`; `generate()` factory
- `Page<T>` — generic paginated result with `hasNextPage`, `hasPreviousPage`, `isEmpty`, `totalPages`; `Equatable where T: Equatable`, `Codable where T: Codable`, `Sendable where T: Sendable`
- `PaginationRequest` — page number, page size, and optional cursor; defaults to page 1, size 20
- `SyzygyTimestamp` — millisecond-precision Unix-epoch instant; `Comparable`, `Codable`, `Sendable`; `now()` factory
- `SyzygyDuration` — typed duration with `.seconds(_:)`, `.minutes(_:)`, `.hours(_:)` factory methods; `Comparable`, `Codable`
- `TimeProvider` — protocol for injectable clock abstraction; `now()` required method
- `ValidationResult` — `.valid` / `.invalid(messages:)` result enum; `isValid` computed property
- `ValidationRule` — generic single-method validation protocol

#### Contracts — Network
- `NetworkMethod` — `get`, `post`, `put`, `patch`, `delete`, `head` enum
- `NetworkRequest` — typed HTTP request value type; default timeout 30 s; `Sendable`
- `NetworkResponse` — typed HTTP response; `isSuccess`, `isClientError`, `isServerError` computed properties; `Sendable`
- `NetworkClientProtocol` — `async throws` network execution contract

#### Contracts — Storage
- `StorageKey<T>` — phantom-typed string key with optional `defaultValue`
- `StorageProvider` — `get`/`set`/`remove`/`clear` storage contract

#### Contracts — Auth
- `AuthToken` — access token, optional refresh token, optional expiry; `isExpired` computed property; `Sendable`
- `AuthState` — `.unauthenticated`, `.authenticated(authToken:)`, `.expired(authToken:)`, `.refreshing` enum; `isAuthenticated`, `token` helpers; `Sendable`
- `AuthProvider` — `AnyPublisher<AuthState, Never>` state + `authenticate`, `refresh`, `signOut` contract

#### Contracts — Analytics
- `AnalyticsEvent` — `name`, `[String: String]` properties, `SyzygyTimestamp` timestamp; `Sendable`
- `AnalyticsProvider` — `track`, `identify(userId:traits:)`, `reset` contract

#### Contracts — Logging
- `LogLevel` — `.debug`, `.info`, `.warning`, `.error`, `.critical` enum; `Comparable`
- `LogEntry` — structured entry with level, message, timestamp, metadata, optional error; `Equatable` excludes `error`; `Sendable`
- `LoggerProtocol` — `log(_:)` abstract method + `debug`, `info`, `warning`, `error`, `critical` extension convenience methods

#### Contracts — Connectivity
- `ConnectivityState` — `.connected`, `.disconnected`, `.unknown` enum; `Sendable`
- `ConnectivityProvider` — `AnyPublisher<ConnectivityState, Never>` state + `isConnected` snapshot

#### Shared Types
- `SyzygyEnvironment` — `.debug`, `.staging`, `.production` enum; `isDebug`, `isProduction` helpers
- `SyzygyConfiguration` — top-level app configuration protocol
- `SyzygyBuildInfo` — consumer-injected app metadata; `Sendable`
- `SyzygyVersion` — semantic version with `Comparable` and `CustomStringConvertible`; `current` is `1.0.0`

#### Errors
- `SyzygyErrorSeverity` — `.info`, `.warning`, `.error`, `.critical` enum
- `SyzygyErrorCode` — extensible string-backed code; predefined: `unknown`, `cancelled`, `timeout`, `unauthenticated`, `forbidden`, `notFound`, `serverError`, `networkUnavailable`, `decodingFailed`, `encodingFailed`
- `SyzygyError` — base error protocol extending `LocalizedError` and `Sendable`; `errorDescription` returns `message`

#### Testing Support (`SyzygyFoundationTesting` — test targets only)
- `MockLogger` — records all `LogEntry` instances; `entries(for:)` filter by `LogLevel`; `clear()`
- `MockConnectivityProvider` — settable `ConnectivityState` via Combine passthrough subject
- `MockAuthProvider` — settable `AuthState`; call counters; configurable `refreshResult`
- `MockStorageProvider` — in-memory dictionary backing store
- `MockNetworkClient` — FIFO response queue; `recordedRequests` list; configurable `error`
- `SpyAnalyticsProvider` — records `trackedEvents`, `identifiedUsers`, `resetCallCount`; `events(named:)` filter
- `FixtureProvider` — protocol + conformances on `SyzygyID`, `AuthToken`, `NetworkRequest`, `NetworkResponse`, `AnalyticsEvent`, `LogEntry`, `SyzygyVersion`
- `FixedTimeProvider` — deterministic `TimeProvider` with mutable `fixedTime`

#### Repository
- `syzygy.yml` manifest added

### Changed
- CI lint config source updated: `swiftlint --config` now fetches from `Syzygy-Hub/.github/main/engineering/tooling/ios/.swiftlint.yml`
- CI coverage step added: `--enable-code-coverage` flag + `llvm-cov report` summary written to `GITHUB_STEP_SUMMARY`
- README rewritten to Syzygy engineering standard

[Unreleased]: https://github.com/Syzygy-Hub/syzygy-foundation-ios/compare/1.0.0...HEAD
[1.0.0]: https://github.com/Syzygy-Hub/syzygy-foundation-ios/releases/tag/1.0.0
