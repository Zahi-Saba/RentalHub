//
//  SharedWidgetData.swift
//  RentalHub
//
//  Created by Zahi Saba on 3/10/2026.
//

import Foundation

struct SharedWidgetData {

    static let appGroup = "group.com.ZahiOrg.RentalHub"
    static let widgetKind = "RentalHubWidget"

    static func saveNextInspection(
        address: String,
        startTime: Date
    ) {

        let defaults = UserDefaults(
            suiteName: appGroup
        )

        defaults?.set(
            address,
            forKey: "nextInspectionAddress"
        )

        defaults?.set(
            startTime,
            forKey: "nextInspectionStartTime"
        )
    }

    static func loadAddress() -> String {

        let defaults = UserDefaults(
            suiteName: appGroup
        )

        if let address = defaults?.string(
            forKey: "nextInspectionAddress"
        ) {
            return address
        }

        return "No upcoming inspection"
    }

    static func loadStartTime() -> Date? {

        let defaults = UserDefaults(
            suiteName: appGroup
        )

        if let savedValue = defaults?.object(
            forKey: "nextInspectionStartTime"
        ) {

            if let date = savedValue as? Date {
                return date
            }
        }

        return nil
    }

    static func clearNextInspection() {

        let defaults = UserDefaults(
            suiteName: appGroup
        )

        defaults?.removeObject(
            forKey: "nextInspectionAddress"
        )

        defaults?.removeObject(
            forKey: "nextInspectionStartTime"
        )
    }
}
