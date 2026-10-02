//
//  InspectionPlannerView.swift
//  RentalHub
//
//  Created by Zahi Saba on 2/10/2026.
//

import Foundation
import SwiftUI

struct InspectionPlannerView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    var body: some View {

        VStack {

            if viewModel.inspections.isEmpty {

                Text("No upcoming inspections scheduled.")

            } else {

                List(viewModel.inspections) { inspection in

                    VStack(alignment: .leading, spacing: 6) {

                        Text(viewModel.propertyAddress(for: inspection.rentalPropertyID))
                        .font(.headline)

                        Text(inspection.startTime,style: .date)

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
        .navigationTitle("Inspection Planner")
        .onAppear {

            viewModel.loadRentalProperties()
            viewModel.loadUpcomingInspections()
        }
    }
}
