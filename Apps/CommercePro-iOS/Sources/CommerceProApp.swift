import SwiftUI

@main
@MainActor
struct CommerceProApp: App {
    private let assembler = AppAssembler()

    var body: some Scene {
        WindowGroup {
            RootView(assembler: assembler)
        }
    }
}
