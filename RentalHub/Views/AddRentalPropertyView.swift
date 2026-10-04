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
    @State private var showConfirmation = false

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
                    .foregroundColor(.red)
            }

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
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
                        showConfirmation = true
                    }

                } else {

                    inputError = "Please enter a valid weekly rent."
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Add Rental Property")
        .alert(
                    "Rental Property Added",
                    isPresented: $showConfirmation
                ) {
                    Button("OK") {
                    }
                } message: {
                    Text(
                        "The rental property was saved successfully."
                    )
                }
            }
        }
