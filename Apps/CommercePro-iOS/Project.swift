import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CommercePro-iOS",
    targets: [
        Target.target(
            name: "CommercePro-iOS",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "com.mycompany.commercepro.ios",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "CommercePro",
                "CFBundleShortVersionString": "1.0.0",
                "CFBundleVersion": "1",
                "UILaunchScreen": [ : ],
                "APP_PRODUCT": "commercePro"
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
                .project(target: "CheckoutPresentation", path: .relativeToRoot("Features/Checkout")),

                .project(target: "PaymentsDomain", path: .relativeToRoot("Features/Payments")),
                .project(target: "PaymentsApplication", path: .relativeToRoot("Features/Payments")),
                .project(target: "PaymentsInfrastructure", path: .relativeToRoot("Features/Payments")),
                .project(target: "PaymentsPresentation", path: .relativeToRoot("Features/Payments"))
            ],
            settings: SettingsFactory.appSettings(for: .commercePro, platform: .iOS)
        )
    ],
    schemes: [
        AppFactory.scheme(appName: "CommercePro-iOS", product: .commercePro)
    ]
)
