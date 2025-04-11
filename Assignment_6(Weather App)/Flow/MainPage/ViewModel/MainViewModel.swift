//
//  MainViewModel.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 10.04.2025.
//
import UIKit

class MainViewModel: ObservableObject {
    @Published var mainInfo: MainInfo?
    @Published var hourlyForecast: [HourlyForecast] = []
    @Published var currentConditionIcon: String = ""
    @Published var tenDayForecast: [ForecastDay] = []
    
    private let service: WeatherServices
    
    init(service: WeatherServices) {
        self.service = service
    }
    
    func fetchCurrentWeather(city: String) async {
        do {
            let weatherResponse = try await service.fetchCurrentWeather(city: city)
            await MainActor.run {
                self.mainInfo = MainInfo(
                    city: city,
                    temp: weatherResponse.current.temp_c,
                    status: weatherResponse.current.condition.text
                )
            }
        } catch {
            print("error in MainViewModel.fetchCurrentWeather: \(error.localizedDescription)")
        }
    }
    
    func fetchHourlyForecast(city: String) async {
        do {
            let forecast = try await service.fetchHourlyForecast(city: city)
            await MainActor.run {
                self.hourlyForecast = forecast.forecast.forecastday.first?.hour ?? []
            }
        } catch {
            print("error in MainViewModel.fetchHourlyForecast: \(error.localizedDescription)")
        }
    }
    
    func fetchTenDayForecast(city: String) async {
        do {
            let forecast = try await service.fetchTenDayForecast(city: city)
            await MainActor.run {
                print("10-day forecast count: \(forecast.forecast.forecastday.count)")
                self.tenDayForecast = forecast.forecast.forecastday
            }
        } catch {
            print("error in MainViewModel.fetchTenDayForecast: \(error.localizedDescription)")
        }
    }
    
    func iconCalculate() {
        if let matchedHour = self.hourlyForecast.first(where: {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let hourDate = formatter.date(from: $0.time) else { return false }
            return Calendar.current.component(.hour, from: hourDate) == Calendar.current.component(.hour, from: Date())
        }) {
            currentConditionIcon = matchedHour.condition.icon
        }
    }
    
    func fetchAllWeather(city: String) async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.fetchCurrentWeather(city: city)
            }
            group.addTask {
                await self.fetchHourlyForecast(city: city)
            }
        }
        await MainActor.run {
            self.iconCalculate()
        }
    }
    
}
