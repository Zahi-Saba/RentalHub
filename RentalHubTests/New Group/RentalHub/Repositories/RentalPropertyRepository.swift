//
//  RentalPropertyRepository.swift
//  RentalHub
//
//  Created by Zahi Saba on 29/9/2026.
//

import Foundation

protocol RentalPropertyRepository {
    func save(_ property: RentalProperty) throws
    
    func save(_ inspection: RentalInspection) throws

    func save(_ observation: InspectionObservation) throws
    }

