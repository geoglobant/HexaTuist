import Foundation
import Combine
import SharedDomain
import CartApplication

@MainActor
public final class CartViewModel: ObservableObject {
    @Published public private(set) var cart: CartSnapshot = CartSnapshot(items: [], total: Money(amount: 0, currency: .brl))

    private let store: CartStorePort
    private let addToCart: AddToCartUseCase

    public init(store: CartStorePort, addToCart: AddToCartUseCase) {
        self.store = store
        self.addToCart = addToCart
    }

    public func load() async {
        let loaded = await store.load()
        cart = CartSnapshot(
            items: loaded.items.map { item in
                CartLine(id: item.id, name: item.name, price: item.price, quantity: item.quantity)
            },
            total: loaded.totalAmount()
        )
    }

    public func add(item: CartItemInput) async {
        cart = await addToCart.execute(item: item)
    }
}
