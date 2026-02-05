import Foundation
import SharedDomain
import CatalogDomain
import CatalogApplication

public final class MockProductRepositoryAdapter: ProductRepositoryPort {
    public init() {}

    public func fetchProducts() async throws -> [Product] {
        let items: [Product] = [
            Product(id: ProductID("p-001"), name: "Cafe Premium", price: Money(amount: 19.90, currency: .brl)),
            Product(id: ProductID("p-002"), name: "Cha Verde", price: Money(amount: 12.50, currency: .brl)),
            Product(id: ProductID("p-003"), name: "Biscoito Artesanal", price: Money(amount: 8.75, currency: .brl))
        ]
        return items
    }
}
