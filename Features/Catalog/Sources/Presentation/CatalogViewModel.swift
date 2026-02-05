import Foundation
import Combine
import CatalogApplication

@MainActor
public final class CatalogViewModel: ObservableObject {
    @Published public private(set) var products: [ProductSummary] = []
    @Published public private(set) var isLoading: Bool = false

    private let getProducts: GetProductsUseCase

    public init(getProducts: GetProductsUseCase) {
        self.getProducts = getProducts
    }

    public func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            products = try await getProducts.execute()
        } catch {
            products = []
        }
    }
}
