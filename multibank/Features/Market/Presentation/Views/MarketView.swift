import SwiftUI

struct MarketView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("live market for multibank")
                .font(.title2.bold())

            Text("my app architecture - dev")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("marketplace")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MarketView()
    }
}
