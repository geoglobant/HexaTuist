import Foundation
import PaymentsDomain
import PaymentsApplication

public final class MockPaymentMethodsAdapter: PaymentMethodsPort {
    public init() {}

    public func fetchMethods() async -> [PaymentMethod] {
        [
            PaymentMethod(id: "card", label: "Cartao"),
            PaymentMethod(id: "pix", label: "Pix")
        ]
    }
}
