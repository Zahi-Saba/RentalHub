//
//  UpdateInspectionObservationUseCase.swift
//  RentalHub
//
//  Created by Zahi Saba on 6/10/2026.
//

import Foundation

enum UpdateInspectionObservationError: Error {

    case missingNotes
    case observationNotFound
}

struct UpdateInspectionObservationUseCase {

    let repository: RentalPropertyRepository

    func execute(
        observation: InspectionObservation,
        status: ObservationStatus,
        notes: String
    ) throws -> InspectionObservation {

        if notes.isEmpty {

            throw UpdateInspectionObservationError
                .missingNotes
        }

        let savedObservations =
            try repository.fetchObservations(
                for: observation.inspectionID
            )

        var observationExists = false

        for savedObservation in savedObservations {

            if savedObservation.id ==
                observation.id {

                observationExists = true
            }
        }

        if observationExists == false {

            throw UpdateInspectionObservationError
                .observationNotFound
        }

        var updatedObservation =
            observation

        updatedObservation.status =
            status

        updatedObservation.notes =
            notes

        try repository.update(
            updatedObservation
        )

        return updatedObservation
    }
}
