import Foundation
import SharedDomain

public enum OrderStatus: String, Codable {
    case pending
    case approved
    case declined
}

public struct Order: Equatable, Identifiable {
    public let id: OrderID
    public let total: Money
    public let status: OrderStatus

    public init(id: OrderID, total: Money, status: OrderStatus) {
        self.id = id
        self.total = total
        self.status = status
    }
}
