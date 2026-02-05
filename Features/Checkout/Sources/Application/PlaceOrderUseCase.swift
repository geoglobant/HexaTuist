import Foundation
import SharedDomain
import CheckoutDomain

public protocol PaymentGatewayPort {
    func authorize(total: Money) async -> Bool
}

public enum OrderState: String {
    case pending
    case approved
    case declined
}

public struct OrderSummary: Equatable, Identifiable {
    public let id: OrderID
    public let total: Money
    public let state: OrderState

    public init(id: OrderID, total: Money, state: OrderState) {
        self.id = id
        self.total = total
        self.state = state
    }
}

public struct PlaceOrderUseCase {
    private let gateway: PaymentGatewayPort

    public init(gateway: PaymentGatewayPort) {
        self.gateway = gateway
    }

    public func execute(total: Money) async -> OrderSummary {
        let approved = await gateway.authorize(total: total)
        let status: OrderStatus = approved ? .approved : .declined
        let order = Order(id: OrderID(UUID().uuidString), total: total, status: status)
        let state: OrderState
        switch order.status {
        case .approved:
            state = .approved
        case .declined:
            state = .declined
        case .pending:
            state = .pending
        }
        return OrderSummary(id: order.id, total: order.total, state: state)
    }
}
