import ProjectDescription

public enum Product: String, CaseIterable {
    case commercePro
    case commerceLite

    public var appProductValue: String {
        rawValue
    }
}
