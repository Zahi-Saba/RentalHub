//
//  RentalInspection.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

struct RentalInspection: Identifiable {

    let id: UUID
    var rentalPropertyID: UUID
    var startTime: Date
    var endTime: Date

    init(
        id: UUID = UUID(),
        rentalPropertyID: UUID,
        startTime: Date,
        endTime: Date
    ) {
        self.id = id
        self.rentalPropertyID = rentalPropertyID
        self.startTime = startTime
        self.endTime = endTime
    }
}
