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
        SimpleEntry(date: Date(), filename: "No screenshot available")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.com.pavlenko.Habo")
        let filename = userDefaults?.string(forKey: "filename") ?? "No screenshot available"
        let entry = SimpleEntry(date: Date(), filename: filename)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            // Schedule next update at midnight to show empty state
            let calendar = Calendar.current
            let now = Date()
            let startOfToday = calendar.startOfDay(for: now)
            let midnight = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
            
            let timeline = Timeline(entries: [entry], policy: .after(midnight))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let filename: String
}

struct HaboWidgetEntryView : View {
    var entry: Provider.Entry
    
    var CustomImage: some View {
        // Determine which image to show based on date
        let userDefaults = UserDefaults(suiteName: "group.com.pavlenko.Habo")
        let lastUpdateDateString = userDefaults?.string(forKey: "lastUpdateDate") ?? ""
        let filenameEmpty = userDefaults?.string(forKey: "filename_empty") ?? ""
        
        // Check if we should show empty state (new day)
        var shouldShowEmpty = false
        if let lastUpdateDate = ISO8601DateFormatter().date(from: lastUpdateDateString) {
            let calendar = Calendar.current
            let lastDay = calendar.startOfDay(for: lastUpdateDate)
            let today = calendar.startOfDay(for: Date())
            shouldShowEmpty = today > lastDay
        }
        
        
        // Choose the appropriate filename
        let imageFilename = shouldShowEmpty ? filenameEmpty : entry.filename

        if let uiImage = UIImage(contentsOfFile: imageFilename) {
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
    SimpleEntry(date: .now, filename: "preview")
}
