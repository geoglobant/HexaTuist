import Foundation
import PaymentsDomain

public struct PaymentMethodSummary: Equatable, Identifiable {
    public let id: String
    public let label: String

    public init(id: String, label: String) {
        self.id = id
        self.label = label
    }
}

public protocol PaymentMethodsPort {
    func fetchMethods() async -> [PaymentMethod]
}

public struct ListPaymentMethodsUseCase {
    private let port: PaymentMethodsPort

    public init(port: PaymentMethodsPort) {
        self.port = port
    }

    public func execute() async -> [PaymentMethodSummary] {
        let methods = await port.fetchMethods()
        return methods.map { method in
            PaymentMethodSummary(id: method.id, label: method.label)
        }
    }
}
