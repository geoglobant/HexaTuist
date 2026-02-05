import Foundation
import SharedDomain
import CheckoutApplication

public final class MockPaymentGatewayAdapter: PaymentGatewayPort {
    public init() {}

    public func authorize(total: Money) async -> Bool {
        total.amount > 0
    }
}
