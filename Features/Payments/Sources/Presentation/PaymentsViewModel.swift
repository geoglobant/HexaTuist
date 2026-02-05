import Foundation
import Combine
import PaymentsApplication

@MainActor
public final class PaymentsViewModel: ObservableObject {
    @Published public private(set) var methods: [PaymentMethodSummary] = []

    private let listMethods: ListPaymentMethodsUseCase

    public init(listMethods: ListPaymentMethodsUseCase) {
        self.listMethods = listMethods
    }

    public func load() async {
        methods = await listMethods.execute()
    }
}
