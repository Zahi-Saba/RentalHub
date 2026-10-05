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

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Text("Property Address")
                    .font(.headline)

                Text(property.address)

                Text("Weekly Rent")
                    .font(.headline)

                Text(
                    "$\(property.weeklyRent, specifier: "%.0f") per week"
                )

                NavigationLink(
                    destination: ScheduleInspectionView(
                        viewModel: viewModel,
                        property: property
                    )
                ) {
                    Text("Schedule Inspection")
                }

                Divider()

                Text("Latest Inspection Notes")
                    .font(.headline)

                if let inspection =
                    viewModel.latestPropertyInspection {

                    HStack {

                        Text(
                            inspection.startTime,
                            style: .date
                        )

                        Text("-")

                        Text(
                            inspection.startTime,
                            style: .time
                        )
                    }
                    ForEach(
                        viewModel.latestPropertyObservations
                    ) { observation in

                        VStack(
                            alignment: .leading,
                            spacing: 5
                        ) {

                            Text(
                                criterionName(
                                    observation.criterion
                                )
                            )
                            .font(.headline)

                            Text(
                                statusName(
                                    observation.status
                                )
                            )

                            Text(observation.notes)
                        }
                        .padding()
                    }

                } else {

                    Text(
                        "No inspection notes saved for this property yet."
                    )
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Property Details")
        .onAppear {

            viewModel.loadLatestInspectionNotes(
                for: property.id
            )
        }
    }

    private func criterionName(
        _ criterion: InspectionCriterion
    ) -> String {

        switch criterion {

        case .noise:
            return "Noise"

        case .daylight:
            return "Daylight"

        case .storage:
            return "Storage"

        case .roomSpace:
            return "Room Space"

        case .transport:
            return "Transport"
        }
    }

    private func statusName(
        _ status: ObservationStatus
    ) -> String {

        switch status {

        case .notChecked:
            return "Not Checked"

        case .meetsNeeds:
            return "Meets Needs"

        case .doesNotMeetNeeds:
            return "Does Not Meet Needs"

        case .needsClarification:
            return "Needs Clarification"
        }
    }
}
