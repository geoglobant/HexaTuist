import SwiftUI
import SharedDomain
import CheckoutApplication
import CheckoutPresentation
import CartApplication
import CartPresentation

struct CheckoutView: View {
    @ObservedObject var viewModel: CheckoutViewModel
    @ObservedObject var cartViewModel: CartViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                let total = cartViewModel.cart.total
                Text("Total: \(format(total))")
                    .font(.title3)

                Button("Place Order") {
                    Task { await viewModel.placeOrder(total: total) }
                }
                .buttonStyle(.borderedProminent)

                if let order = viewModel.order {
                    Text("Status: \(order.state.rawValue)")
                        .font(.headline)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Checkout")
        }
    }

    private func format(_ money: Money) -> String {
        let number = NSDecimalNumber(decimal: money.amount)
        return "\(money.currency.rawValue) \(number)"
    }
}
