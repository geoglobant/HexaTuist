import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Catalog",
    targets: [
        Target.target(
            name: "CatalogDomain",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.catalog.domain",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Domain/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CatalogApplication",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.catalog.application",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Application/**"],
            dependencies: [
                .target(name: "CatalogDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CatalogInfrastructure",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.catalog.infrastructure",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Infrastructure/**"],
            dependencies: [
                .target(name: "CatalogApplication"),
                .target(name: "CatalogDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CatalogPresentation",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.catalog.presentation",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Presentation/**"],
            dependencies: [
                .target(name: "CatalogApplication"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
