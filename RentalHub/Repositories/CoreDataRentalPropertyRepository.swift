//
//  CoreDataRentalPropertyRepository.swift
//  RentalHub
//
//  Created by Zahi Saba on 1/10/2026.
//

import Foundation
import CoreData

enum CoreDataRentalPropertyRepositoryError: Error {
    case rentalPropertyNotFound
    case inspectionNotFound
}

class CoreDataRentalPropertyRepository: RentalPropertyRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(_ property: RentalProperty) throws {

        let propertyEntity = RentalPropertyEntity(context: context)

        propertyEntity.id = property.id
        propertyEntity.address = property.address
        propertyEntity.weeklyRent = property.weeklyRent

        try context.save()
    }

    func save(_ inspection: RentalInspection) throws {

        let request = RentalPropertyEntity.fetchRequest()

        request.predicate = NSPredicate(
            format: "id == %@",
            inspection.rentalPropertyID as CVarArg
        )

        let properties = try context.fetch(request)

        if properties.isEmpty {
            throw CoreDataRentalPropertyRepositoryError.rentalPropertyNotFound
        }

        let inspectionEntity = RentalInspectionEntity(context: context)

        inspectionEntity.id = inspection.id
        inspectionEntity.startTime = inspection.startTime
        inspectionEntity.endTime = inspection.endTime
        inspectionEntity.rentalProperty = properties[0]

        try context.save()
    }

    func save(_ observation: InspectionObservation) throws {

        let request = RentalInspectionEntity.fetchRequest()

        request.predicate = NSPredicate(
            format: "id == %@",
            observation.inspectionID as CVarArg
        )

        let inspections = try context.fetch(request)

        if inspections.isEmpty {
            throw CoreDataRentalPropertyRepositoryError.inspectionNotFound
        }

        let observationEntity = InspectionObservationEntity(context: context)

        observationEntity.id = observation.id
        observationEntity.criterion = observation.criterion.rawValue
        observationEntity.status = observation.status.rawValue
        observationEntity.notes = observation.notes
        observationEntity.inspection = inspections[0]

        try context.save()
    }
    func fetchRentalProperties() throws -> [RentalProperty] {

        let request = RentalPropertyEntity.fetchRequest()

        let entities = try context.fetch(request)

        var properties: [RentalProperty] = []

        for entity in entities {

            if let id = entity.id,
               let address = entity.address {

                let property = RentalProperty(
                    id: id,
                    address: address,
                    weeklyRent: entity.weeklyRent
                )

                properties.append(property)
            }
        }

        return properties
    }
    
}
