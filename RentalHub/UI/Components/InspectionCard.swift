//
//  InspectionCard.swift
//  RentalHub
//
//  Created by Zahi Saba on 5/10/2026.
//

import SwiftUI

struct InspectionCard: View {

    let inspection: RentalInspection
    let address: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            HStack {

                Image(
                    systemName: "mappin.circle.fill"
                )
                .foregroundColor(
                    RentalHubTheme.accent
                )

                Text(address)
                    .font(.headline)
                    .foregroundColor(
                        RentalHubTheme.mainText
                    )

                Spacer()

                Image(
                    systemName: "chevron.right"
                )
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )
            }

            HStack {

                Image(
                    systemName: "calendar"
                )
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )

                Text(
                    inspection.startTime,
                    style: .date
                )
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )
            }

            HStack {

                Image(
                    systemName: "clock"
                )
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )

                Text(
                    inspection.startTime,
                    style: .time
                )

                Text("-")

                Text(
                    inspection.endTime,
                    style: .time
                )
            }
            .foregroundColor(
                RentalHubTheme.secondaryText
            )
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(
            RentalHubTheme.card
        )
        .cornerRadius(15)
    }
}
