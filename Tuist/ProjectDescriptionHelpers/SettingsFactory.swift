import ProjectDescription

public enum SettingsFactory {
    public static func appSettings(for product: Product, platform: Platform) -> Settings {
        let _ = product
        var base: SettingsDictionary = [
            "SWIFT_VERSION": "5.9",
            "MARKETING_VERSION": "1.0.0",
            "CURRENT_PROJECT_VERSION": "1"
        ]

        switch platform {
        case .iOS:
            base["IPHONEOS_DEPLOYMENT_TARGET"] = "15.0"
            base["TARGETED_DEVICE_FAMILY"] = "1,2"
        case .macOS:
            base["MACOSX_DEPLOYMENT_TARGET"] = "13.0"
        default:
            break
        }

        return Settings.settings(base: base)
    }

    public static func frameworkSettings() -> Settings {
        Settings.settings(base: [
            "SWIFT_VERSION": "5.9"
        ])
    }
}
