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

        return observation
    }
}
