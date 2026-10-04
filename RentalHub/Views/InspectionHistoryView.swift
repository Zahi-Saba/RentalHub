//
//  InspectionHistoryView.swift
//  RentalHub
//
//  Created by Zahi Saba on 4/10/2026.
//

import SwiftUI

struct InspectionHistoryView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    var body: some View {

        VStack {

            if viewModel.inspectionHistory.isEmpty {

                Text("No past inspections.")

            } else {

                List(
                    viewModel.inspectionHistory
                ) { inspection in

                    NavigationLink(
                        destination: InspectionChecklistView(
                            viewModel: viewModel,
                            inspection: inspection
                        )
                    ) {

                        VStack(
                            alignment: .leading,
                            spacing: 6
                        ) {

                            Text(
                                viewModel.propertyAddress(
                                    for: inspection.rentalPropertyID
                                )
                            )
                            .font(.headline)

                            Text(
                                inspection.startTime,
                                style: .date
                            )

                            HStack {

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
                        }
                    }
                }
            }
        }
        .navigationTitle("Inspection History")
        .onAppear {

            viewModel.loadRentalProperties()
            viewModel.loadInspectionHistory()
        }
    }
}
