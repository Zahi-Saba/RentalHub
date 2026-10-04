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

    @State private var startTime = Date()
    @State private var endTime = Date()

    @State private var showConfirmation = false

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
                    .foregroundColor(.red)
            }

            Button("Schedule Inspection") {

                viewModel.scheduleInspection(
                    rentalPropertyID: property.id,
                    startTime: startTime,
                    endTime: endTime
                )

                if viewModel.errorMessage.isEmpty {

                    showConfirmation = true
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Schedule Inspection")

        .alert(
            "Inspection Scheduled",
            isPresented: $showConfirmation
        ) {
            Button("OK") {
            }
        } message: {
            Text(
                "The inspection was scheduled successfully."
            )
        }
    }
}
