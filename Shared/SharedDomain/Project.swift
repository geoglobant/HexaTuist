import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "SharedDomain",
    targets: [
        Target.target(
            name: "SharedDomain",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "com.mycompany.shared.shareddomain",
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "13.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            settings: SettingsFactory.frameworkSettings()
        )
    ]
)
