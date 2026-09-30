//
//  RentalHubTests.swift
//  RentalHubTests
//
//  Created by Zahi Saba on 29/9/2026.
//
import Foundation
import Testing
@testable import RentalHub

@MainActor
struct RentalHubTests {
    
    @Test
    func savesValidRentalProperty() throws {
        
        let repository = MockRentalPropertyRepository()
        
        let useCase = SaveRentalPropertyUseCase(
            repository: repository
        )
        
        let property = try useCase.execute(
            address: "15 George Street",
            weeklyRent: 650
        )
        
        #expect(property.address == "15 George Street")
        #expect(property.weeklyRent == 650)
        #expect(repository.savedProperties.count == 1)
    }
    
    @Test
    func rejectsMissingAddress() {
        
        let repository = MockRentalPropertyRepository()
        
        let useCase = SaveRentalPropertyUseCase(
            repository: repository
        )
        
        #expect(throws: SaveRentalPropertyError.self) {
            try useCase.execute(
                address: "",
                weeklyRent: 650
            )
        }
        
        #expect(repository.savedProperties.count == 0)
    }
    
    @Test
    func rejectsZeroWeeklyRent() {
        
        let repository = MockRentalPropertyRepository()
        
        let useCase = SaveRentalPropertyUseCase(
            repository: repository
        )
        
        #expect(throws: SaveRentalPropertyError.self) {
            try useCase.execute(
                address: "15 George Street",
                weeklyRent: 0
            )
        }
        
        #expect(repository.savedProperties.count == 0)
    }
    
    @Test
    func rejectsInspectionWithSameStartAndEndTime() {
        
        let repository = MockRentalPropertyRepository()
        
        let useCase = ScheduleInspectionUseCase(
            repository: repository
        )
        
        let propertyID = UUID()
        let inspectionTime = Date()
        
        #expect(throws: ScheduleInspectionError.self) {
            try useCase.execute(
                rentalPropertyID: propertyID,
                startTime: inspectionTime,
                endTime: inspectionTime
            )
        }
        
        #expect(repository.savedInspections.count == 0)
    }
    @Test
    func rejectsObservationWithMissingNotes() {
        
        let repository = MockRentalPropertyRepository()
        
        let useCase = RecordInspectionObservationUseCase(
            repository: repository
        )
        
        #expect(throws: RecordInspectionObservationError.self) {
            try useCase.execute(
                inspectionID: UUID(),
                criterion: .storage,
                status: .needsClarification,
                notes: ""
            )
        }
        
        #expect(repository.savedObservations.count == 0)
    }
    
    //happy path
    @Test
    func savesValidInspectionObservation() throws {

        let repository = MockRentalPropertyRepository()

        let useCase = RecordInspectionObservationUseCase(
            repository: repository
        )

        let observation = try useCase.execute(
            inspectionID: UUID(),
            criterion: .storage,
            status: .meetsNeeds,
            notes: "Plenty of wardrobe space"
        )

        #expect(observation.notes == "Plenty of wardrobe space")
        #expect(repository.savedObservations.count == 1)
    }
}

    
