//
//  AddRentalPropertyView.swift
//  RentalHub
//
//  Created by Zahi Saba on 2/10/2026.
//

import SwiftUI

struct AddRentalPropertyView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    @State private var address: String = ""
    @State private var weeklyRent: String = ""
    @State private var inputError: String = ""

    var body: some View {

        VStack(spacing: 20) {

            TextField(
                "Property address",
                text: $address
            )
            .textFieldStyle(.roundedBorder)

            TextField(
                "Weekly rent",
                text: $weeklyRent
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)

            if !inputError.isEmpty {
                Text(inputError)
            }

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
            }

            Button("Save Rental Property") {

                if let rent = Double(weeklyRent) {

                    viewModel.addRentalProperty(
                        address: address,
                        weeklyRent: rent
                    )

                    if viewModel.errorMessage.isEmpty {
                        address = ""
                        weeklyRent = ""
                        inputError = ""
                    }

                } else {

                    inputError = "Please enter a valid weekly rent."
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Add Rental Property")
    }
}
