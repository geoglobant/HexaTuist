import Foundation
import Combine
import SharedDomain
import CheckoutApplication

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published public private(set) var order: OrderSummary?

    private let placeOrder: PlaceOrderUseCase

    public init(placeOrder: PlaceOrderUseCase) {
        self.placeOrder = placeOrder
    }

    public func placeOrder(total: Money) async {
        order = await placeOrder.execute(total: total)
    }
}
