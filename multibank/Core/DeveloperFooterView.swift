//
//  DeveloperFooterView.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import SwiftUI

struct DeveloperFooterView: View {
    private let linkedInURL = URL(string: "https://ae.linkedin.com/in/shehzad-sulaiman-8a657815b")!

    var body: some View {
        Link(destination: linkedInURL) {
            Text("developed by shehzadsulaiman")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.brown)
                .underline()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .background(.ultraThinMaterial)
    }
}
