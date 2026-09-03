[![iOS](https://img.shields.io/badge/iOS-Swift-7F77DD?style=flat)](https://developer.apple.com/ios/) [![Swift](https://img.shields.io/badge/Swift-6.0-1D9E75?logo=swift&logoColor=white&style=flat)](https://swift.org) [![CI](https://img.shields.io/github/actions/workflow/status/Syzygy-Hub/syzygy-foundation-ios/ci.yml?label=ci&style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-ios/actions/workflows/ci.yml) [![Version](https://img.shields.io/badge/version-1.1.0-D85A30?style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-ios/releases) [![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-dark-1200.png">
  <img src="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-light-1200.png" alt="Syzygy" width="600">
</picture>

# syzygy-foundation-ios

The root layer of the Syzygy ecosystem — providing SharedTypes, base protocols, and shared contracts that every peer layer builds on.

## About

syzygy-foundation-ios is the base layer that every other Syzygy iOS library depends on. It defines the protocols that Services implements, the value types that UI and Core consume, and the error types the whole stack shares. Nothing in Foundation has behaviour beyond property storage — no network calls, no platform APIs, no business logic. Swap any implementation in Services or Core by conforming to these contracts; Foundation never needs to change.

## Role in the Syzygy Ecosystem

`syzygy-foundation-ios` is the root layer — the only dependency shared by all peer layers. It depends on nothing. Every peer layer (UI, Core, Services, AI) depends on Foundation and nothing else.

Full ecosystem architecture: [ecosystem-fragment.md](https://github.com/Syzygy-Hub/.github/blob/main/docs/ecosystem-fragment.md)

### Shared Contracts

Foundation defines the shared contracts that all peer layers consume. These contracts are the abstraction layer that allows UI, Core, Services and AI to each depend on Foundation without depending on each other.

- **`NetworkClientProtocol`** — abstracts HTTP networking so any peer layer can make network requests without depending on a concrete implementation. `syzygy-services-ios` provides the concrete URLSession implementation.
- **`AuthProvider`** — abstracts authentication and token management. `syzygy-services-ios` provides the concrete OAuth and keychain implementations.
- **`StorageProvider`** — abstracts local persistence. `syzygy-services-ios` provides the concrete Keychain implementation.
- **`LoggerProtocol`** — abstracts logging and observability so all peer layers can log without depending on a specific logging framework.

> These contracts are currently defined as planned interfaces. Concrete implementations will ship with `syzygy-services-ios` in Phase 2 of the ecosystem roadmap.

## Release Process

Releases follow the Syzygy tag-push release flow:

1. Create a `release/X.X.X` branch
2. Bump the version in `syzygy.yml`, `Package.swift` (via git tag — SPM uses tags), the README badge, `CHANGELOG.md`, and `Sources/SyzygyFoundation/SharedTypes/SyzygyVersion.swift`
3. Open a PR to `main` and wait for CI to pass
4. Merge the PR
5. Push the tag: `git tag X.X.X` and `git push origin X.X.X`
6. The tag push triggers the org-level release workflow which validates `syzygy.yml` matches the tag, extracts the CHANGELOG entry, and creates the GitHub Release

For the full release standard see the [Syzygy-Hub/.github release standard](https://github.com/Syzygy-Hub/.github/blob/main/engineering/standards/release-standard.md).

## Platforms

| Platform | Min Version | Package Manager | Status |
|---|---|---|---|
| iOS | 16.0+ | SPM | ✅ Supported |

## Requirements

- iOS 16.0+
- Swift 6.0+
- Xcode 16+

## Installation

```swift
// In Package.swift
.package(url: "https://github.com/Syzygy-Hub/syzygy-foundation-ios", from: "1.1.0")

// Add to your target dependencies
.product(name: "SyzygyFoundation", package: "syzygy-foundation-ios")

// For test targets only
.product(name: "SyzygyFoundationTesting", package: "syzygy-foundation-ios")
```

## Architecture

SyzygyFoundation exposes two targets:

- **SyzygyFoundation** — runtime contracts and primitives. Import in your app and library targets.
- **SyzygyFoundationTesting** — test support (mocks, spies, fixtures). Import in test targets only.

**Depends on:** nothing

**Used by:** syzygy-ui-ios, syzygy-core-ios, syzygy-services-ios, syzygy-ai-ios

For the full ecosystem architecture see [syzygy-ecosystem.md](https://github.com/Syzygy-Hub/.github/blob/main/engineering/architecture/syzygy-ecosystem.md).

## API

### Primitives

- `SyzygyID<T>` — phantom-typed UUID-backed identifier preventing accidental ID mixing
- `Page<T>` / `PaginationRequest` — paginated data structures
- `SyzygyTimestamp` / `SyzygyDuration` / `TimeProvider` — cross-platform time primitives
- `ValidationResult` / `ValidationRule` — validation contract and result type

### Contracts

- `NetworkClientProtocol` / `NetworkRequest` / `NetworkResponse` — networking contract
- `StorageProvider` / `StorageKey` — type-safe storage contract
- `AuthProvider` / `AuthToken` / `AuthState` — authentication contract
- `AnalyticsProvider` / `AnalyticsEvent` — analytics contract
- `LoggerProtocol` / `LogLevel` / `LogEntry` — logging contract
- `ConnectivityProvider` / `ConnectivityState` — connectivity contract

### Shared Types

- `SyzygyEnvironment` — debug / staging / production
- `SyzygyConfiguration` — app configuration contract
- `SyzygyBuildInfo` — consumer-injected build metadata
- `SyzygyVersion` — semantic version with comparison support

### Errors

- `SyzygyError` — base error protocol
- `SyzygyErrorCode` — typed, extensible error codes
- `SyzygyErrorSeverity` — error severity levels

### Testing Support

Import `SyzygyFoundationTesting` in test targets only.

- `MockLogger`, `MockConnectivityProvider`, `MockAuthProvider`, `MockStorageProvider`, `MockNetworkClient`
- `SpyAnalyticsProvider`
- `FixtureProvider`, `FixedTimeProvider`

## Usage

### Implementing a contract

```swift
import SyzygyFoundation

final class URLSessionNetworkClient: NetworkClientProtocol {
    func execute(_ request: NetworkRequest) async throws -> NetworkResponse {
        var urlRequest = URLRequest(url: URL(string: request.url)!)
        urlRequest.httpMethod = request.method.rawValue
        request.headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let http = response as! HTTPURLResponse
        return NetworkResponse(statusCode: http.statusCode, data: data, headers: [:])
    }
}
```

### Using a primitive

```swift
import SyzygyFoundation

struct User { let id: SyzygyID<User>; let name: String }
struct Post { let id: SyzygyID<Post>; let title: String }

let userId = SyzygyID<User>.generate()
let postId = SyzygyID<Post>.generate()
// userId == postId  // compile error — different phantom types
```

### Using test support

```swift
import XCTest
import SyzygyFoundationTesting

final class MyServiceTests: XCTestCase {
    func testFetchReturnsData() async throws {
        let client = MockNetworkClient()
        let response = NetworkResponse(statusCode: 200, data: Data(), headers: [:])
        client.enqueue(response)
        let result = try await client.execute(NetworkRequest(url: "https://example.com"))
        XCTAssertEqual(result.statusCode, 200)
    }
}
```

## Platform Notes

- Async pattern: `async throws`
- `SyzygyError` conforms to `LocalizedError` — `errorDescription` returns `message`
- `ConnectivityProvider`: self-detecting via `NWPathMonitor`
- `SyzygyBuildInfo`: inject at app startup from `Bundle.main`

## Contributing

Contributions are welcome. Please follow the [Syzygy engineering standards](https://github.com/Syzygy-Hub/.github/tree/main/engineering/standards) when submitting pull requests.

## License

MIT — see [LICENSE](LICENSE)
