import SwiftUI
import SharedDomain
import CatalogApplication
import CatalogPresentation
import CartApplication
import CartPresentation

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @ObservedObject var cartViewModel: CartViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text(format(product.price))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Add") {
                            let item = CartItemInput(id: product.id, name: product.name, price: product.price, quantity: 1)
                            Task { await cartViewModel.add(item: item) }
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .navigationTitle("Catalog")
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
