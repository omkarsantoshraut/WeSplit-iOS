import SwiftUI

@main
struct WeSplitApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
                // no-op
            }
        }
    }
}
