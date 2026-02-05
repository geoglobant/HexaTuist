import Foundation

public enum CurrencyCode: String, CaseIterable, Codable {
    case brl = "BRL"
    case usd = "USD"
    case eur = "EUR"
}

public struct Money: Equatable, Hashable, Codable {
    public let amount: Decimal
    public let currency: CurrencyCode

    public init(amount: Decimal, currency: CurrencyCode) {
        self.amount = amount
        self.currency = currency
    }

    public static func +(lhs: Money, rhs: Money) -> Money {
        precondition(lhs.currency == rhs.currency, "Currency mismatch")
        return Money(amount: lhs.amount + rhs.amount, currency: lhs.currency)
    }
}

public protocol TypedID: Hashable, Codable {
    var rawValue: String { get }
    init(_ rawValue: String)
}

public struct UserID: TypedID {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public struct ProductID: TypedID {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public struct OrderID: TypedID {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public enum DomainError: Error, Equatable {
    case invalidValue(String)
    case notFound(String)
    case unauthorized
    case unknown(String)
}
