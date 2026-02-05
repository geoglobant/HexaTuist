import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ProductKit",
    targets: [
        Target.target(
            name: "ProductKit",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.shared.productkit",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain"))
            ],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
