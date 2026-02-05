import SwiftUI

@main
@MainActor
struct CommerceLiteMacApp: App {
    private let assembler = AppAssembler()

    var body: some Scene {
        WindowGroup {
            RootView(assembler: assembler)
        }
    }
}
