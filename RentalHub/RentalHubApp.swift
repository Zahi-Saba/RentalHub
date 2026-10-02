//
//  RentalHubApp.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//
import CoreData
import SwiftUI

@main
struct RentalHubApp: App {

    @StateObject private var viewModel: RentalHubViewModel

    init() {

        let context = PersistenceController.shared.container.viewContext

        let repository = CoreDataRentalPropertyRepository(
            context: context
        )

        _viewModel = StateObject(
            wrappedValue: RentalHubViewModel(
                repository: repository
            )
        )
    }

    var body: some Scene {

        WindowGroup {

            RentalPropertyListView(
                viewModel: viewModel
            )
        }
    }
}
