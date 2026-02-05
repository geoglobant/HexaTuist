import Foundation
import SharedDomain
import CatalogDomain

public struct ProductSummary: Equatable, Identifiable {
    public let id: ProductID
    public let name: String
    public let price: Money

    public init(id: ProductID, name: String, price: Money) {
        self.id = id
        self.name = name
        self.price = price
    }
}

public protocol ProductRepositoryPort {
    func fetchProducts() async throws -> [Product]
}

public struct GetProductsUseCase {
    private let repository: ProductRepositoryPort

    public init(repository: ProductRepositoryPort) {
        self.repository = repository
    }

    public func execute() async throws -> [ProductSummary] {
        let products = try await repository.fetchProducts()
        return products.map { product in
            ProductSummary(id: product.id, name: product.name, price: product.price)
        }
    }
}
