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

        ZStack {

            RentalHubTheme.background
                .ignoresSafeArea()

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        HStack {

                            Image(
                                systemName: "house.fill"
                            )
                            .font(.title2)
                            .foregroundColor(
                                RentalHubTheme.accent
                            )

                            Text("Property")
                                .font(.headline)
                                .foregroundColor(
                                    RentalHubTheme.secondaryText
                                )
                        }

                        Text(property.address)
                            .font(.title2)
                            .bold()
                            .foregroundColor(
                                RentalHubTheme.mainText
                            )

                        Text(
                            "$\(property.weeklyRent, specifier: "%.0f") per week"
                        )
                        .font(.headline)
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

                    NavigationLink(
                        destination: ScheduleInspectionView(
                            viewModel: viewModel,
                            property: property
                        )
                    ) {

                        PrimaryButton(
                            title: "Schedule Inspection",
                            icon: "calendar.badge.plus"
                        )
                    }

                    SectionTitle(
                        title: "Latest Inspection Notes"
                    )

                    if let inspection =
                        viewModel.latestPropertyInspection {

                        HStack {

                            Image(
                                systemName: "clock"
                            )
                            .foregroundColor(
                                RentalHubTheme.accent
                            )

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
                        .foregroundColor(
                            RentalHubTheme.secondaryText
                        )

                        ForEach(
                            viewModel.latestPropertyObservations
                        ) { observation in

                            ObservationCard(
                                observation: observation
                            )
                        }

                    } else {

                        VStack(spacing: 10) {

                            Image(
                                systemName:
                                    "checklist"
                            )
                            .font(.title)
                            .foregroundColor(
                                RentalHubTheme.secondaryText
                            )

                            Text(
                                "No inspection notes saved yet."
                            )
                            .foregroundColor(
                                RentalHubTheme.secondaryText
                            )
                        }
                        .frame(
                            maxWidth: .infinity
                        )
                        .padding(25)
                        .background(
                            RentalHubTheme.card
                        )
                        .cornerRadius(15)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Property Details")
        .navigationBarTitleDisplayMode(
            .inline
        )
        .onAppear {

            viewModel.loadLatestInspectionNotes(
                for: property.id
            )
        }
        .preferredColorScheme(.dark)
    }
}
