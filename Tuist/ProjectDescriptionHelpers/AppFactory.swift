import ProjectDescription

public enum AppFactory {
    public static func scheme(appName: String, product: Product) -> Scheme {
        Scheme.scheme(
            name: "\(appName)-\(product.rawValue)",
            shared: true,
            buildAction: .buildAction(targets: [
                .target(appName)
            ]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .debug)
        )
    }
}
