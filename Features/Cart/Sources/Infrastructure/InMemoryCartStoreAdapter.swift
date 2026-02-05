import Foundation
import CartDomain
import CartApplication

public actor InMemoryCartStoreAdapter: CartStorePort {
    private var cart: Cart = Cart()

    public init() {}

    public func load() async -> Cart {
        cart
    }

    public func save(_ cart: Cart) async {
        self.cart = cart
    }
}
