import SwiftUI

@main
@MainActor
struct CommerceProMacApp: App {
    private let assembler = AppAssembler()

    var body: some Scene {
        WindowGroup {
            RootView(assembler: assembler)
        }
    }
}
