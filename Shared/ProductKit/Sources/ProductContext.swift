import Foundation

public enum AppProduct: String, CaseIterable {
    case commercePro
    case commerceLite
}

public struct ProductContext {
    public let product: AppProduct

    public init(product: AppProduct) {
        self.product = product
    }

    public static var current: ProductContext {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "APP_PRODUCT") as? String,
              let product = AppProduct(rawValue: value) else {
            return ProductContext(product: .commerceLite)
        }
        return ProductContext(product: product)
    }
}
