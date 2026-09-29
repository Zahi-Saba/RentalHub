//
//  SaveRentalPropertyUseCase.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

enum SaveRentalPropertyError: Error {
    case missingAddress
    case invalidWeeklyRent
}

struct SaveRentalPropertyUseCase {

    private let repository: RentalPropertyRepository

    init(repository: RentalPropertyRepository) {
        self.repository = repository
    }

    func execute(address: String, weeklyRent: Double) throws -> RentalProperty {

        guard !address.isEmpty else {
            throw SaveRentalPropertyError.missingAddress
        }

        guard weeklyRent > 0 else {
            throw SaveRentalPropertyError.invalidWeeklyRent
        }

        let property = RentalProperty(
            address: address,
            weeklyRent: weeklyRent
        )

        try repository.save(property)

        return property
    }
}
