//
//  RecordInspectionObservationUseCase.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

enum RecordInspectionObservationError: Error {
    case missingNotes
}
//An observation must have a note.
struct RecordInspectionObservationUseCase {

    private let repository: RentalPropertyRepository

    init(repository: RentalPropertyRepository) {
        self.repository = repository
    }

    func execute(
        inspectionID: UUID,
        criterion: InspectionCriterion,
        status: ObservationStatus,
        notes: String
    ) throws -> InspectionObservation {

        if notes.isEmpty {
            throw RecordInspectionObservationError.missingNotes
        }

        let observation = InspectionObservation(
            inspectionID: inspectionID,
            criterion: criterion,
            status: status,
            notes: notes
        )

        try repository.save(observation)

        return observation
    }
}
