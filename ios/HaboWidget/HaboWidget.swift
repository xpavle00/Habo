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
        let entry = createEntry(for: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        var entries: [SimpleEntry] = []
        
        // Generate entries for the next 48 hours, every hour
        for hourOffset in 0..<48 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = createEntry(for: entryDate)
            entries.append(entry)
        }

        // Use .atEnd policy to request a new timeline when these entries run out
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func createEntry(for date: Date) -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.com.pavlenko.Habo")
        let filename = userDefaults?.string(forKey: "filename") ?? "No screenshot available"
        let filenameEmpty = userDefaults?.string(forKey: "filename_empty") ?? ""
        let lastUpdateDateString = userDefaults?.string(forKey: "lastUpdateDate") ?? ""
        
        // Parse date safely handling fractional seconds
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        // Fallback formatter without fractional seconds
        let fallbackFormatter = ISO8601DateFormatter()
        
        var shouldShowEmpty = false
        if let lastUpdateDate = formatter.date(from: lastUpdateDateString) ?? fallbackFormatter.date(from: lastUpdateDateString) {
            let calendar = Calendar.current
            let lastDay = calendar.startOfDay(for: lastUpdateDate)
            let checkDay = calendar.startOfDay(for: date)
            shouldShowEmpty = checkDay > lastDay
        }
        
        // Determine which filename to use based on the target date
        let displayFilename = shouldShowEmpty ? filenameEmpty : filename
        
        return SimpleEntry(date: date, displayFilename: displayFilename)
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
        // Fallback UI when image is not available
        return AnyView(
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    Text("Habo")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Update from app")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
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
