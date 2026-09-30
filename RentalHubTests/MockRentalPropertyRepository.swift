//
//  MockRentalPropertyRepository.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation
@testable import RentalHub

class MockRentalPropertyRepository: RentalPropertyRepository {

    var savedProperties: [RentalProperty] = []
    var savedInspections: [RentalInspection] = []
    var savedObservations: [InspectionObservation] = []

    func save(_ property: RentalProperty) throws {
        savedProperties.append(property)
    }

    func save(_ inspection: RentalInspection) throws {
        savedInspections.append(inspection)
    }

    func save(_ observation: InspectionObservation) throws {
        savedObservations.append(observation)
    }
    func fetchRentalProperties() throws -> [RentalProperty] {
        return savedProperties
    }
}
