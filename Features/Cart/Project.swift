import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Cart",
    targets: [
        Target.target(
            name: "CartDomain",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.cart.domain",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Domain/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CartApplication",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.cart.application",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Application/**"],
            dependencies: [
                .target(name: "CartDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CartInfrastructure",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.cart.infrastructure",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Infrastructure/**"],
            dependencies: [
                .target(name: "CartApplication"),
                .target(name: "CartDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CartPresentation",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.cart.presentation",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Presentation/**"],
            dependencies: [
                .target(name: "CartApplication"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
