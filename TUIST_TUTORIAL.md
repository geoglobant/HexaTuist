# Tuist Setup Tutorial (HexaTuist)

This document explains how this repo is structured and how to reproduce the setup with Tuist. It also captures the fixes we applied while getting the workspace running.

## Why Tuist

We use Tuist because it lets us:

- Keep **`Project.swift`/`Workspace.swift`** as the source of truth.
- Model **Clean/Hexagonal Architecture** with **separate targets** (Domain/Application/Infrastructure/Presentation).
- Support **multiple products (white-label)** in a single monorepo.
- Generate Xcode projects/schemes consistently.

## Prerequisites

- **Xcode 26+** (tested with 26.2)
- **Tuist 4.138.0** (the manifests in this repo match this API)

Install Tuist (if needed):

```sh
brew install tuist@4
```

## How It’s Organized

```
.
├── Workspace.swift
├── Tuist.swift
├── Tuist/ProjectDescriptionHelpers
│   ├── AppFactory.swift
│   ├── Product.swift
│   └── SettingsFactory.swift
├── Apps
│   ├── CommercePro-iOS
│   ├── CommercePro-macOS
│   ├── CommerceLite-iOS
│   └── CommerceLite-macOS
├── Shared
│   ├── SharedDomain
│   └── ProductKit
└── Features
    ├── Catalog
    ├── Cart
    ├── Checkout
    └── Payments
```

### Key Ideas

- **Apps** (Shells) contain SwiftUI Views + Composition Root (`AppAssembler`).
- **Features** follow Hexagonal:
  - `<Feature>Domain` (entities/rules)
  - `<Feature>Application` (use cases + ports)
  - `<Feature>Infrastructure` (adapters)
  - `<Feature>Presentation` (ViewModels, mappers)
- **SharedDomain** contains reusable domain types (`Money`, IDs, errors).
- **ProductKit** reads `APP_PRODUCT` from Info.plist to expose `ProductContext`.

## Generate the Xcode Workspace

From the repo root:

```sh
tuist generate
```

This creates `HexaTuist.xcworkspace` and all `.xcodeproj` files. These are **generated** and should not be committed.

## Adding a New Feature

1. Create the feature folder:

```
Features/NewFeature
  ├── Project.swift
  └── Sources
      ├── Domain
      ├── Application
      ├── Infrastructure
      └── Presentation
```

2. Copy the structure of another feature’s `Project.swift` (Catalog/Cart/etc).
3. Add the feature project path to `Workspace.swift`.
4. Add dependencies in the app targets (or other modules).
5. `tuist generate`

## Adding a New Product (White‑Label)

1. Create a new app project (iOS/macOS) under `Apps/`.
2. Add its `Project.swift` with:
   - Unique `bundleId`
   - `infoPlist: .extendingDefault(with: [...])`
   - `APP_PRODUCT` set to the product name
3. Add it to `Workspace.swift`.
4. Create schemes using `AppFactory.scheme(...)`.
5. `tuist generate`

## Known Issues We Fixed (Keep in Mind)

### 1) Tuist config file name
**Fix:** Use `Tuist.swift` at the root. `Tuist/Config.swift` is deprecated.

### 2) Tuist 4.x API changes

- `Scheme(...)` → `Scheme.scheme(...)`
- `Target(...)` → `Target.target(...)`
- Use `TargetReference.target("Name")` instead of `TargetReference(projectPath:...)`

### 3) Deployment Targets (important!)

If you don’t set `deploymentTargets`, the framework may default to the latest iOS version, causing:

> “module has a minimum deployment target of iOS XX”

**Fix:** Explicitly set deployment targets in every target, for example:

```swift
deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0")
```

### 4) Missing bundle ID

If you use `infoPlist: .dictionary(...)`, the bundle ID can disappear at runtime.

**Fix:** Always use:

```swift
infoPlist: .extendingDefault(with: [...])
```

### 5) iOS 15 compatibility

`NavigationStack` is iOS 16+. Since we target iOS 15, all iOS views use:

```swift
NavigationView { ... }
```

## Common Commands

```sh
tuist generate
tuist graph
```

## Notes

- Frameworks are **not runnable** on the simulator by themselves.
- To run a feature, use an **App target** (e.g., CommerceLite‑iOS).

