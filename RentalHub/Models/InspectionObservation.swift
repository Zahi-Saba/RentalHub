//
//  InspectionObservation.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

enum InspectionCriterion: String {
    case noise
    case daylight
    case storage
    case roomSpace
    case transport
}

enum ObservationStatus: String {
    case notChecked
    case meetsNeeds
    case doesNotMeetNeeds
    case needsClarification
}

struct InspectionObservation: Identifiable {
    let id = UUID()
    var inspectionID: UUID
    var criterion: InspectionCriterion
    var status: ObservationStatus
    var notes: String
}
