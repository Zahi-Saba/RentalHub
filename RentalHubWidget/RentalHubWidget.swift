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
        completion: @escaping (Timeline<RentalHubWidgetEntry>) -> Void
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

    @Environment(\.widgetFamily)
    private var family

    var body: some View {

        if family == .systemSmall {

            smallWidget

        } else if family == .systemMedium {

            mediumWidget

        } else {

            Text("Widget size not supported.")
        }
    }

    var smallWidget: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            HStack {

                Image(
                    systemName: "house.fill"
                )
                .foregroundColor(
                    RentalHubTheme.accent
                )

                Text("RentalHub")
                    .font(.headline)
                    .foregroundColor(
                        RentalHubTheme.mainText
                    )
            }

            Spacer()

            Text("Next Inspection")
                .font(.caption)
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )

            Text(entry.address)
                .font(.headline)
                .foregroundColor(
                    RentalHubTheme.mainText
                )
                .lineLimit(2)

            if let startTime = entry.startTime {

                HStack {

                    Image(
                        systemName: "clock"
                    )

                    Text(
                        startTime,
                        style: .time
                    )
                }
                .font(.caption)
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )

            } else {

                Text(
                    "No inspection scheduled."
                )
                .font(.caption)
                .foregroundColor(
                    RentalHubTheme.secondaryText
                )
            }
        }
    }

    var mediumWidget: some View {

        HStack(spacing: 18) {

            ZStack {

                RoundedRectangle(
                    cornerRadius: 15
                )
                .fill(
                    RentalHubTheme.secondaryCard
                )
                .frame(
                    width: 65,
                    height: 65
                )

                Image(
                    systemName: "house.fill"
                )
                .font(.title)
                .foregroundColor(
                    RentalHubTheme.accent
                )
            }

            VStack(
                alignment: .leading,
                spacing: 7
            ) {

                Text("Next Rental Inspection")
                    .font(.headline)
                    .foregroundColor(
                        RentalHubTheme.mainText
                    )

                Text(entry.address)
                    .font(.title3)
                    .bold()
                    .foregroundColor(
                        RentalHubTheme.mainText
                    )
                    .lineLimit(1)

                if let startTime = entry.startTime {

                    HStack {

                        Image(
                            systemName: "calendar"
                        )

                        Text(
                            startTime,
                            style: .date
                        )

                        Image(
                            systemName: "clock"
                        )

                        Text(
                            startTime,
                            style: .time
                        )
                    }
                    .font(.caption)
                    .foregroundColor(
                        RentalHubTheme.secondaryText
                    )

                } else {

                    Text(
                        "No upcoming inspection scheduled."
                    )
                    .foregroundColor(
                        RentalHubTheme.secondaryText
                    )
                }
            }

            Spacer()
        }
    }
}

struct RentalHubWidget: Widget {

    let kind: String =
        SharedWidgetData.widgetKind

    var body: some WidgetConfiguration {

        StaticConfiguration(
            kind: kind,
            provider: RentalHubWidgetProvider()
        ) { entry in

            RentalHubWidgetView(
                entry: entry
            )
            .containerBackground(
                RentalHubTheme.background,
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
