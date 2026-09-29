//
//  RentalInspection.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation
struct RentalInspection: Identifiable {
    let id = UUID()
    var rentalPropertyID: UUID
    var startTime: Date
    var endTime: Date
}
