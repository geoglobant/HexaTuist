import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Payments",
    targets: [
        Target.target(
            name: "PaymentsDomain",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.payments.domain",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Domain/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "PaymentsApplication",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.payments.application",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Application/**"],
            dependencies: [
                .target(name: "PaymentsDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "PaymentsInfrastructure",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.payments.infrastructure",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Infrastructure/**"],
            dependencies: [
                .target(name: "PaymentsApplication"),
                .target(name: "PaymentsDomain"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        ),
        Target.target(
            name: "PaymentsPresentation",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.features.payments.presentation",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/Presentation/**"],
            dependencies: [
                .target(name: "PaymentsApplication"),
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
