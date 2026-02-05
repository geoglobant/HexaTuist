import Foundation
import ProductKit

import CatalogApplication
import CatalogInfrastructure
import CatalogPresentation

import CartApplication
import CartInfrastructure
import CartPresentation

import CheckoutApplication
import CheckoutInfrastructure
import CheckoutPresentation

@MainActor
final class AppAssembler {
    let productContext: ProductContext
    let catalogViewModel: CatalogViewModel
    let cartViewModel: CartViewModel
    let checkoutViewModel: CheckoutViewModel

    private let cartStore: InMemoryCartStoreAdapter

    init() {
        productContext = ProductContext.current

        let productRepository = MockProductRepositoryAdapter()
        let getProducts = GetProductsUseCase(repository: productRepository)
        catalogViewModel = CatalogViewModel(getProducts: getProducts)

        cartStore = InMemoryCartStoreAdapter()
        let addToCart = AddToCartUseCase(store: cartStore)
        cartViewModel = CartViewModel(store: cartStore, addToCart: addToCart)

        let paymentGateway = MockPaymentGatewayAdapter()
        let placeOrder = PlaceOrderUseCase(gateway: paymentGateway)
        checkoutViewModel = CheckoutViewModel(placeOrder: placeOrder)
    }
}
