import Foundation
import SharedDomain
import CartDomain

public struct CartItemInput: Equatable {
    public let id: ProductID
    public let name: String
    public let price: Money
    public let quantity: Int

    public init(id: ProductID, name: String, price: Money, quantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

public struct CartLine: Equatable, Identifiable {
    public let id: ProductID
    public let name: String
    public let price: Money
    public let quantity: Int

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

public struct CartSnapshot: Equatable {
    public let items: [CartLine]
    public let total: Money

    public init(items: [CartLine], total: Money) {
        self.items = items
        self.total = total
    }
}

public protocol CartStorePort {
    func load() async -> Cart
    func save(_ cart: Cart) async
}

public struct AddToCartUseCase {
    private let store: CartStorePort

    public init(store: CartStorePort) {
        self.store = store
    }

    public func execute(item: CartItemInput) async -> CartSnapshot {
        var cart = await store.load()
        let domainItem = CartItem(id: item.id, name: item.name, price: item.price, quantity: item.quantity)

        if let index = cart.items.firstIndex(where: { $0.id == domainItem.id }) {
            cart.items[index].quantity += domainItem.quantity
        } else {
            cart.items.append(domainItem)
        }

        await store.save(cart)
        return snapshot(from: cart)
    }
}

private func snapshot(from cart: Cart) -> CartSnapshot {
    let items = cart.items.map { item in
        CartLine(id: item.id, name: item.name, price: item.price, quantity: item.quantity)
    }
    let total = cart.totalAmount()
    return CartSnapshot(items: items, total: total)
}
