//
//  RentalPropertyListView.swift
//  RentalHub
//
//  Created by Zahi Saba on 30/9/2026.
//

import Foundation
import SwiftUI

struct RentalPropertyListView: View {

    @ObservedObject var viewModel: RentalHubViewModel

    var body: some View {

        NavigationView {

            VStack {

                if viewModel.rentalProperties.isEmpty {

                    Text("No rental properties saved yet.")

                } else {

                    List(viewModel.rentalProperties) { property in

                        VStack(alignment: .leading) {

                            Text(property.address)

                            Text("Weekly rent: $\(property.weeklyRent)")
                        }
                    }
                }
            }
            .navigationTitle("Rental Shortlist")
        }
    }
}
