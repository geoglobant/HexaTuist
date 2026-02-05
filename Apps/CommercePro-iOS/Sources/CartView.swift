import SwiftUI
import SharedDomain
import CartApplication
import CartPresentation

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.cart.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Qtd: \(item.quantity)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(format(item.total()))
                            .font(.subheadline)
                    }
                }

                if viewModel.cart.items.isEmpty {
                    Text("Cart empty")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Cart")
            .task {
                await viewModel.load()
            }
        }
    }

    private func format(_ money: Money) -> String {
        let number = NSDecimalNumber(decimal: money.amount)
        return "\(money.currency.rawValue) \(number)"
    }
}
