//
//  RentalPropertyCard.swift
//  RentalHub
//
//  Created by Zahi Saba on 5/10/2026.
//

import SwiftUI

struct RentalPropertyCard: View {

    let property: RentalProperty

    var body: some View {

        HStack(spacing: 15) {

            Image(
                systemName: "house.fill"
            )
            .font(.title2)
            .foregroundColor(
                RentalHubTheme.accent
            )
            .frame(
                width: 50,
                height: 50
            )
            .background(
                RentalHubTheme.secondaryCard
            )
            .cornerRadius(12)

            VStack(
                alignment: .leading,
                spacing: 6
            ) {

                Text(property.address)
                    .font(.headline)
                    .foregroundColor(
                        RentalHubTheme.mainText
                    )

                Text(
                    "$\(property.weeklyRent, specifier: "%.0f") per week"
                )
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
