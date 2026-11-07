//
//  HaboWidgetBundle.swift
//  HaboWidget
//
//  Created by Peter Pavlenko on 07/11/2025.
//

import SwiftUI
import WidgetKit

@main
struct HaboWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodayWidget()
        CheckInWidget()
        HeatmapWidget()
    }
}
