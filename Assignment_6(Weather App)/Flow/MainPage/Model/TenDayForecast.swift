//
//  TenDayForecast.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 11.04.2025.
//
import UIKit

struct TenDayForecast: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let minTemp: Int
    let maxTemp: Int
}
