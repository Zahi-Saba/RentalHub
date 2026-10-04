//
//  RentalPropertyDetailView.swift
//  RentalHub
//
//  Created by Zahi Saba on 2/10/2026.
//

import SwiftUI

struct RentalPropertyDetailView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    let property: RentalProperty

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("Property Address")
                .font(.headline)

            Text(property.address)

            Text("Weekly Rent")
                .font(.headline)

            Text("$\(property.weeklyRent, specifier: "%.0f") per week")

            NavigationLink(
                destination: ScheduleInspectionView(
                    viewModel: viewModel,
                    property: property
                )
            ) {
                Text("Schedule Inspection")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Property Details")
    }
}
