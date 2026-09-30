//
//  MockRentalPropertyRepository.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

class MockRentalPropertyRepository: RentalPropertyRepository {

    var savedProperties: [RentalProperty] = []

    func save(_ property: RentalProperty) throws {
        savedProperties.append(property)
    }
}
