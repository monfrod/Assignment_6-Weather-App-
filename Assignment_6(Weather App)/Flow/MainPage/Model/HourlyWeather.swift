//
//  HourlyWeather.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 09.04.2025.
//
import SwiftUI

struct HourlyWeather: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Int
    let systemImageName: String
}
