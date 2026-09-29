//
//  ScheduleInspectionUseCase.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

enum ScheduleInspectionError: Error {
    case invalidTime
}

struct ScheduleInspectionUseCase {

    func execute(
        rentalPropertyID: UUID,
        startTime: Date,
        endTime: Date
    ) throws -> RentalInspection {

        if endTime <= startTime {
            throw ScheduleInspectionError.invalidTime
        }

        let inspection = RentalInspection(
            rentalPropertyID: rentalPropertyID,
            startTime: startTime,
            endTime: endTime
        )

        return inspection
    }
}
