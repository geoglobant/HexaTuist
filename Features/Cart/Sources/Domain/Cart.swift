import Foundation
import SharedDomain

public struct CartItem: Equatable, Identifiable {
    public let id: ProductID
    public let name: String
    public let price: Money
    public var quantity: Int

    public init(id: ProductID, name: String, price: Money, quantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }

    public func total() -> Money {
        Money(amount: price.amount * Decimal(quantity), currency: price.currency)
    }
}

public struct Cart: Equatable {
    public var items: [CartItem]

    public init(items: [CartItem] = []) {
        self.items = items
    }

    public func totalAmount(defaultCurrency: CurrencyCode = .brl) -> Money {
        guard let first = items.first else {
            return Money(amount: 0, currency: defaultCurrency)
        }

        return items.reduce(Money(amount: 0, currency: first.price.currency)) { partial, item in
            partial + item.total()
        }
    }
}
