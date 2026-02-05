import Foundation
import SharedDomain

public struct Product: Equatable, Identifiable {
    public let id: ProductID
    public let name: String
    public let price: Money

    public init(id: ProductID, name: String, price: Money) {
        self.id = id
        self.name = name
        self.price = price
    }
}
