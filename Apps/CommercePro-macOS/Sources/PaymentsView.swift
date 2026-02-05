import SwiftUI
import PaymentsApplication
import PaymentsPresentation

struct PaymentsView: View {
    @ObservedObject var viewModel: PaymentsViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.methods) { method in
                    Text(method.label)
                }

                if viewModel.methods.isEmpty {
                    Text("No methods")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Payments")
            .task {
                await viewModel.load()
            }
        }
    }
}
