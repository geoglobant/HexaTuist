import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CommerceLite-iOS",
    targets: [
        Target.target(
            name: "CommerceLite-iOS",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "com.mycompany.commercelite.ios",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "CommerceLite",
                "CFBundleShortVersionString": "1.0.0",
                "CFBundleVersion": "1",
                "UILaunchScreen": [ : ],
                "APP_PRODUCT": "commerceLite"
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "SharedDomain", path: .relativeToRoot("Shared/SharedDomain")),
                .project(target: "ProductKit", path: .relativeToRoot("Shared/ProductKit")),

                .project(target: "CatalogDomain", path: .relativeToRoot("Features/Catalog")),
                .project(target: "CatalogApplication", path: .relativeToRoot("Features/Catalog")),
                .project(target: "CatalogInfrastructure", path: .relativeToRoot("Features/Catalog")),
                .project(target: "CatalogPresentation", path: .relativeToRoot("Features/Catalog")),

                .project(target: "CartDomain", path: .relativeToRoot("Features/Cart")),
                .project(target: "CartApplication", path: .relativeToRoot("Features/Cart")),
                .project(target: "CartInfrastructure", path: .relativeToRoot("Features/Cart")),
                .project(target: "CartPresentation", path: .relativeToRoot("Features/Cart")),

                .project(target: "CheckoutDomain", path: .relativeToRoot("Features/Checkout")),
                .project(target: "CheckoutApplication", path: .relativeToRoot("Features/Checkout")),
                .project(target: "CheckoutInfrastructure", path: .relativeToRoot("Features/Checkout")),
                .project(target: "CheckoutPresentation", path: .relativeToRoot("Features/Checkout"))
            ],
            settings: SettingsFactory.appSettings(for: .commerceLite, platform: .iOS)
        )
    ],
    schemes: [
        AppFactory.scheme(appName: "CommerceLite-iOS", product: .commerceLite)
    ]
)
