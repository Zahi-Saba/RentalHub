//
//  RentalHubViewModel.swift
//  RentalHub
//
//  Created by Zahi Saba on 30/9/2026.
//

import Foundation
import Combine

class RentalHubViewModel: ObservableObject {

    @Published var rentalProperties: [RentalProperty] = []
    @Published var inspections: [RentalInspection] = []
    @Published var observations: [InspectionObservation] = []
    @Published var errorMessage: String = ""

    private let repository: RentalPropertyRepository

    private let saveRentalPropertyUseCase: SaveRentalPropertyUseCase
    private let scheduleInspectionUseCase: ScheduleInspectionUseCase
    private let recordInspectionObservationUseCase: RecordInspectionObservationUseCase

    init(repository: RentalPropertyRepository) {

        self.repository = repository

        self.saveRentalPropertyUseCase = SaveRentalPropertyUseCase(
            repository: repository
        )

        self.scheduleInspectionUseCase = ScheduleInspectionUseCase(
            repository: repository
        )

        self.recordInspectionObservationUseCase = RecordInspectionObservationUseCase(
            repository: repository
        )
    }

    func loadRentalProperties() {

        do {

            rentalProperties = try repository.fetchRentalProperties()
            errorMessage = ""

        } catch {

            errorMessage = "Saved rental properties could not be loaded."
        }
    }

    func addRentalProperty(
        address: String,
        weeklyRent: Double
    ) {

        do {

            let property = try saveRentalPropertyUseCase.execute(
                address: address,
                weeklyRent: weeklyRent
            )

            rentalProperties.append(property)
            errorMessage = ""

        } catch SaveRentalPropertyError.missingAddress {

            errorMessage = "Please enter the property address."

        } catch SaveRentalPropertyError.invalidWeeklyRent {

            errorMessage = "Weekly rent must be greater than $0."

        } catch {

            errorMessage = "The property could not be saved. Please try again."
        }
    }

    func scheduleInspection(
        rentalPropertyID: UUID,
        startTime: Date,
        endTime: Date
    ) {

        do {

            let inspection = try scheduleInspectionUseCase.execute(
                rentalPropertyID: rentalPropertyID,
                startTime: startTime,
                endTime: endTime
            )

            inspections.append(inspection)
            errorMessage = ""

        } catch ScheduleInspectionError.invalidTime {

            errorMessage = "The inspection end time must be after the start time."

        } catch {

            errorMessage = "The inspection could not be scheduled. Please try again."
        }
    }

    func recordObservation(
        inspectionID: UUID,
        criterion: InspectionCriterion,
        status: ObservationStatus,
        notes: String
    ) {

        do {

            let observation = try recordInspectionObservationUseCase.execute(
                inspectionID: inspectionID,
                criterion: criterion,
                status: status,
                notes: notes
            )

            observations.append(observation)
            errorMessage = ""

        } catch RecordInspectionObservationError.missingNotes {

            errorMessage = "Please add a note about what you observed."

        } catch {

            errorMessage = "The observation could not be saved. Please try again."
        }
    }
}
