//
//  HaboWidget.swift
//  HaboWidget
//
//  Created by Peter Pavlenko on 07/11/2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), displayFilename: "No screenshot available")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // Just show the current state for snapshot
        let userDefaults = UserDefaults(suiteName: "group.com.pavlenko.Habo")
        let filename = userDefaults?.string(forKey: "filename") ?? "No screenshot available"
        let entry = SimpleEntry(date: Date(), displayFilename: filename)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        var entries: [SimpleEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.com.pavlenko.Habo")
        let filename = userDefaults?.string(forKey: "filename") ?? "No screenshot available"
        let filenameEmpty = userDefaults?.string(forKey: "filename_empty") ?? ""
        
        // Calculate the exact moment of next midnight
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: currentDate)
        let nextMidnight = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
        
        // LOOP 1: Generate hourly entries for TODAY (using current filename)
        // We go hour by hour until we hit midnight
        var checkDate = currentDate
        while checkDate < nextMidnight {
            let entry = SimpleEntry(date: checkDate, displayFilename: filename)
            entries.append(entry)
            checkDate = calendar.date(byAdding: .hour, value: 1, to: checkDate)!
        }
        
        // LOOP 2: Generate hourly entries for the next 7 DAYS (using empty filename)
        // We continue from where we left off (>= midnight) for 7 days
        // This ensures that as soon as the clock ticks past midnight, the widget sees the empty file
        let endOfTimeline = calendar.date(byAdding: .day, value: 7, to: nextMidnight)!
        
        // Ensure we explicitly add the midnight entry exactly
        if entries.last?.date != nextMidnight {
             let midnightEntry = SimpleEntry(date: nextMidnight, displayFilename: filenameEmpty)
             entries.append(midnightEntry)
        }

        // Fill the rest of the timeline with empty state
        checkDate = calendar.date(byAdding: .hour, value: 1, to: nextMidnight)!
        while checkDate < endOfTimeline {
            let entry = SimpleEntry(date: checkDate, displayFilename: filenameEmpty)
            entries.append(entry)
            checkDate = calendar.date(byAdding: .hour, value: 1, to: checkDate)!
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let displayFilename: String
}

struct HaboWidgetEntryView : View {
    var entry: Provider.Entry
    
    var CustomImage: some View {
        if let uiImage = UIImage(contentsOfFile: entry.displayFilename) {
            let image = Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
            
            return AnyView(image)
        }
        // Fallback UI when image is not available - matches app design
        let haboGreen = Color(red: 9/255, green: 191/255, blue: 48/255) // #09BF30
        
        return AnyView(
            ZStack {
                VStack(spacing: 6) {
                    // Title matching Flutter widget
                    Text("Habits today")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
                    
                    // Circular progress ring container
                    ZStack {
                        // Background ring
                        Circle()
                            .stroke(Color.gray.opacity(0.25), lineWidth: 10)
                            .frame(width: 100, height: 100)
                        
                        // Accent ring segment (decorative)
                        Circle()
                            .trim(from: 0, to: 0.25)
                            .stroke(
                                haboGreen.opacity(0.6),
                                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                            )
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-90))
                        
                        // Center content
                        VStack(spacing: 2) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(haboGreen)
                            
                            Text("Add habits")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        )
    }
    
    var body: some View {
        CustomImage
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .clipped()
            .widgetURL(URL(string: "habo://open"))
    }
}

struct HaboWidget: Widget {
    let kind: String = "HaboWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HaboWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HaboWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Habo Habits")
        .description("Track your daily habit progress")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    HaboWidget()
} timeline: {
    SimpleEntry(date: .now, displayFilename: "preview")
}
