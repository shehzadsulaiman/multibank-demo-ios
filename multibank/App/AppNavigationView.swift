import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("shehzads marketplace") {
                    MarketView()
                }
            }
            .navigationTitle("multibank")
        }
    }
}

#Preview {
    AppNavigationView()
}
