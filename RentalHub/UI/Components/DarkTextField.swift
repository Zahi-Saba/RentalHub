//
//  DarkTextField.swift
//  RentalHub
//
//  Created by Zahi Saba on 5/10/2026.
//

import SwiftUI

struct DarkTextField: View {

    let title: String
    let placeholder: String

    @Binding var text: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .font(.headline)
                .foregroundColor(
                    RentalHubTheme.mainText
                )

            TextField(
                placeholder,
                text: $text
            )
            .padding()
            .foregroundColor(
                RentalHubTheme.mainText
            )
            .background(
                RentalHubTheme.card
            )
            .cornerRadius(12)
        }
    }
}
