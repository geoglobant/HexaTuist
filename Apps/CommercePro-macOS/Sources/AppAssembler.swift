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

import PaymentsApplication
import PaymentsInfrastructure
import PaymentsPresentation

@MainActor
final class AppAssembler {
    let productContext: ProductContext
    let catalogViewModel: CatalogViewModel
    let cartViewModel: CartViewModel
    let checkoutViewModel: CheckoutViewModel
    let paymentsViewModel: PaymentsViewModel

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

        let paymentMethods = MockPaymentMethodsAdapter()
        let listMethods = ListPaymentMethodsUseCase(port: paymentMethods)
        paymentsViewModel = PaymentsViewModel(listMethods: listMethods)
    }
}
