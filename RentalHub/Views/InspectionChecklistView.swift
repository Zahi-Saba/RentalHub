//
//  InspectionChecklistView.swift
//  RentalHub
//
//  Created by Zahi Saba on 2/10/2026.
//

import Foundation
import SwiftUI

struct InspectionChecklistView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    let inspection: RentalInspection

    @State private var criterion: InspectionCriterion = .noise
    @State private var status: ObservationStatus = .notChecked
    @State private var notes: String = ""

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                Text(
                    viewModel.propertyAddress(
                        for: inspection.rentalPropertyID
                    )
                )
                .font(.headline)

                Picker(
                    "Inspection Criterion",
                    selection: $criterion
                ) {

                    ForEach(
                        InspectionCriterion.allCases,
                        id: \.self
                    ) { criterion in

                        Text(criterion.rawValue)
                    }
                }

                Picker(
                    "Status",
                    selection: $status
                ) {

                    ForEach(
                        ObservationStatus.allCases,
                        id: \.self
                    ) { status in

                        Text(status.rawValue)
                    }
                }

                TextField(
                    "Inspection notes",
                    text: $notes
                )
                .textFieldStyle(.roundedBorder)

                if !viewModel.errorMessage.isEmpty {

                    Text(viewModel.errorMessage)
                }

                Button("Save Observation") {

                    viewModel.recordObservation(
                        inspectionID: inspection.id,
                        criterion: criterion,
                        status: status,
                        notes: notes
                    )

                    if viewModel.errorMessage.isEmpty {
                        notes = ""
                    }
                }

                Divider()

                Text("Saved Observations")
                    .font(.headline)

                if viewModel.observations.isEmpty {

                    Text("No observations saved yet.")

                } else {

                    ForEach(viewModel.observations) { observation in

                        VStack(
                            alignment: .leading,
                            spacing: 6
                        ) {

                            Text(observation.criterion.rawValue)
                                .font(.headline)

                            Text(
                                "Status: \(observation.status.rawValue)"
                            )

                            Text(
                                "Notes: \(observation.notes)"
                            )
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding()
                        .background(
                            Color.gray.opacity(0.1)
                        )
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Inspection Checklist")
        .onAppear {

            viewModel.loadObservations(
                for: inspection.id
            )
        }
    }
}
