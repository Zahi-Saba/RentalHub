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
    func fetchUpcomingInspections() throws -> [RentalInspection] {

        return savedInspections
            .filter { $0.endTime >= Date() }
            .sorted { $0.startTime < $1.startTime }
    }
    func fetchInspections(
        for rentalPropertyID: UUID
    ) throws -> [RentalInspection] {

        return savedInspections.filter {
            $0.rentalPropertyID == rentalPropertyID
        }
    }

    func fetchObservations(
        for inspectionID: UUID
    ) throws -> [InspectionObservation] {

        return savedObservations.filter {
            $0.inspectionID == inspectionID
        }
    }
}
