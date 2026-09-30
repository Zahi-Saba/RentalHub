//
//  RentalProerty.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//
import Foundation

struct RentalProperty: Identifiable {

    let id: UUID
    var address: String
    var weeklyRent: Double

    init(
        id: UUID = UUID(),
        address: String,
        weeklyRent: Double
    ) {
        self.id = id
        self.address = address
        self.weeklyRent = weeklyRent
    }
}
