import SwiftUI
import ProductKit
import CatalogPresentation
import CartPresentation
import CheckoutPresentation
import PaymentsPresentation

struct RootView: View {
    @StateObject private var catalogViewModel: CatalogViewModel
    @StateObject private var cartViewModel: CartViewModel
    @StateObject private var checkoutViewModel: CheckoutViewModel
    @StateObject private var paymentsViewModel: PaymentsViewModel

    private let productContext: ProductContext

    init(assembler: AppAssembler) {
        _catalogViewModel = StateObject(wrappedValue: assembler.catalogViewModel)
        _cartViewModel = StateObject(wrappedValue: assembler.cartViewModel)
        _checkoutViewModel = StateObject(wrappedValue: assembler.checkoutViewModel)
        _paymentsViewModel = StateObject(wrappedValue: assembler.paymentsViewModel)
        productContext = assembler.productContext
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("Product: \(productContext.product.rawValue)")
                .font(.caption)
                .padding(.top, 8)

            TabView {
                CatalogView(viewModel: catalogViewModel, cartViewModel: cartViewModel)
                    .tabItem { Text("Catalog") }

                CartView(viewModel: cartViewModel)
                    .tabItem { Text("Cart") }

                CheckoutView(viewModel: checkoutViewModel, cartViewModel: cartViewModel)
                    .tabItem { Text("Checkout") }

                PaymentsView(viewModel: paymentsViewModel)
                    .tabItem { Text("Payments") }
            }
        }
    }
}
