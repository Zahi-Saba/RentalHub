//
//  ScheduleInspectionView.swift
//  RentalHub
//
//  Created by Zahi Saba on 2/10/2026.
//

import SwiftUI

struct ScheduleInspectionView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    let property: RentalProperty

    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()

    var body: some View {

        VStack(spacing: 20) {

            Text(property.address)
                .font(.headline)

            DatePicker(
                "Start Time",
                selection: $startTime
            )

            DatePicker(
                "End Time",
                selection: $endTime
            )

            if !viewModel.errorMessage.isEmpty {

                Text(viewModel.errorMessage)
            }

            Button("Schedule Inspection") {

                viewModel.scheduleInspection(
                    rentalPropertyID: property.id,
                    startTime: startTime,
                    endTime: endTime
                )
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Schedule Inspection")
    }
}
