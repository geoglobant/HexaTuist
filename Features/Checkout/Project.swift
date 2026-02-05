import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Checkout",
    targets: [
        Target.target(
            name: "CheckoutDomain",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.checkout.domain",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Domain/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CheckoutApplication",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.checkout.application",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Application/**"],
            dependencies: [
                .target(name: "CheckoutDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CheckoutInfrastructure",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.checkout.infrastructure",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Infrastructure/**"],
            dependencies: [
                .target(name: "CheckoutApplication"),
                .target(name: "CheckoutDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "CheckoutPresentation",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.checkout.presentation",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Presentation/**"],
            dependencies: [
                .target(name: "CheckoutApplication"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
