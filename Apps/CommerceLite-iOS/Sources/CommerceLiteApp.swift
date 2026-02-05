import SwiftUI

@main
@MainActor
struct CommerceLiteApp: App {
    private let assembler = AppAssembler()

    var body: some Scene {
        WindowGroup {
            RootView(assembler: assembler)
        }
    }
}
