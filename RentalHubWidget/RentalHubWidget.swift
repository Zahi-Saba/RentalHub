//
//  RentalHubWidget.swift
//  RentalHubWidget
//
//  Created by Zahi Saba on 3/10/2026.
//

import WidgetKit
import SwiftUI

struct RentalHubWidgetEntry: TimelineEntry {

    let date: Date
    let address: String
    let startTime: Date?
}

struct RentalHubWidgetProvider: TimelineProvider {

    func placeholder(
        in context: Context
    ) -> RentalHubWidgetEntry {

        RentalHubWidgetEntry(
            date: Date(),
            address: "15 George Street",
            startTime: Date()
        )
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (RentalHubWidgetEntry) -> Void
    ) {

        let entry = createEntry()

        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (
            Timeline<RentalHubWidgetEntry>
        ) -> Void
    ) {

        let entry = createEntry()

        let timeline = Timeline(
            entries: [entry],
            policy: .never
        )

        completion(timeline)
    }

    private func createEntry() -> RentalHubWidgetEntry {

        return RentalHubWidgetEntry(
            date: Date(),
            address: SharedWidgetData.loadAddress(),
            startTime: SharedWidgetData.loadStartTime()
        )
    }
}

struct RentalHubWidgetView: View {

    var entry: RentalHubWidgetEntry

    @Environment(\.widgetFamily) private var family

    var body: some View {

        if family == .systemSmall {

            VStack(alignment: .leading, spacing: 8) {

                Text("Next Inspection")
                    .font(.headline)

                Text(entry.address)
                    .font(.subheadline)
                    .bold()

                if let startTime = entry.startTime {

                    Text(
                        startTime,
                        style: .date
                    )

                    Text(
                        startTime,
                        style: .time
                    )

                } else {

                    Text("No inspection scheduled.")
                }

                Spacer()
            }

        } else if family == .systemMedium {

            VStack(alignment: .leading, spacing: 10) {

                Text("Next Rental Inspection")
                    .font(.headline)

                Text(entry.address)
                    .font(.title3)
                    .bold()

                if let startTime = entry.startTime {

                    HStack {

                        Text(
                            startTime,
                            style: .date
                        )

                        Text("-")

                        Text(
                            startTime,
                            style: .time
                        )
                    }

                } else {

                    Text("No upcoming inspection scheduled.")
                }

                Spacer()
            }

        } else {

            Text("Widget size not supported.")
        }
    }
}

struct RentalHubWidget: Widget {

    let kind: String = SharedWidgetData.widgetKind

    var body: some WidgetConfiguration {

        StaticConfiguration(
            kind: kind,
            provider: RentalHubWidgetProvider()
        ) { entry in

            RentalHubWidgetView(
                entry: entry
            )
            .containerBackground(
                Color.white,
                for: .widget
            )
        }
        .configurationDisplayName(
            "Next Rental Inspection"
        )
        .description(
            "View your next scheduled rental inspection."
        )
        .supportedFamilies([
            .systemSmall,
            .systemMedium
        ])
    }
}
