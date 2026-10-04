//
//  RentalPropertyListView.swift
//  RentalHub
//
//  Created by Zahi Saba on 30/9/2026.
//

import SwiftUI

struct RentalPropertyListView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    var body: some View {

        NavigationView {

            VStack {

                NavigationLink(
                    destination: AddRentalPropertyView(
                        viewModel: viewModel
                    )
                ) {
                    Text("Add Rental Property")
                }
                .padding()

                NavigationLink(
                    destination: SharedPropertyPreviewView()
                ) {
                    Text("View Shared Properties")
                }
                .padding()

                if viewModel.rentalProperties.isEmpty {

                    Text("No rental properties saved yet.")

                } else {
                    
                    List {
                        ForEach(
                            viewModel.rentalProperties) {property in

                            NavigationLink(
                                destination: RentalPropertyDetailView(
                                    viewModel: viewModel,
                                    property: property
                                )
                            ) {

                                VStack(
                                    alignment: .leading
                                ) {

                                    Text(property.address)

                                    Text("Weekly rent: $\(property.weeklyRent, specifier: "%.0f")")
                                }
                            }
                        }
                        .onDelete { indexSet in

                            for index in indexSet {

                                let property =
                                    viewModel.rentalProperties[index]

                                viewModel.deleteRentalProperty(
                                    property
                                )
                            }
                        }
                    }
                }

                NavigationLink(
                    destination: InspectionPlannerView(
                        viewModel: viewModel
                    )
                ) {
                    Text("View Inspection Planner")
                }
                .padding()
            }
            .navigationTitle("Rental Shortlist")
            .onAppear {
                viewModel.loadRentalProperties()
            }
        }
    }
}
