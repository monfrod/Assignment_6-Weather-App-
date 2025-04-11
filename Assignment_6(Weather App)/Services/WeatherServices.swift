//
//  WeatherServices.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 10.04.2025.
//
import UIKit

protocol WeatherServices {
    func fetchCurrentWeather(city: String) async throws -> WeatherResponse
    func fetchHourlyForecast(city: String) async throws -> WeatherHourlyForecast
    func fetchTenDayForecast(city: String) async throws -> WeatherTenDayForecast
}

class WeatherServicesImpl: WeatherServices {
    
    func fetchCurrentWeather(city: String) async throws -> WeatherResponse {
        let apiString = "https://api.weatherapi.com/v1/current.json?key=e070e14888c84485aa5102423251004&q=\(city)"
        guard let url = URL(string: apiString) else { throw WeatherError.wrongApi }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weather
        } catch {
            print(error.localizedDescription)
            throw WeatherError.failure
        }
    }
    
    func fetchHourlyForecast(city: String) async throws -> WeatherHourlyForecast{
        let apiString = "https://api.weatherapi.com/v1/forecast.json?key=e070e14888c84485aa5102423251004&q=\(city)&days=1&aqi=no&alerts=no"
        guard let url = URL(string: apiString) else { throw WeatherError.wrongApi }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            let forecast = try JSONDecoder().decode(WeatherHourlyForecast.self, from: data)
            return forecast
        } catch {
            print(error.localizedDescription)
            throw WeatherError.failure
        }
    }
    
    func fetchTenDayForecast(city: String) async throws -> WeatherTenDayForecast {
        let apiString = "https://api.weatherapi.com/v1/forecast.json?key=e070e14888c84485aa5102423251004&q=\(city)&days=10&aqi=no&alerts=no"
        guard let url = URL(string: apiString) else { throw WeatherError.wrongApi }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            let forecast = try JSONDecoder().decode(WeatherTenDayForecast.self, from: data)
            return forecast
        } catch {
            print(error.localizedDescription)
            throw WeatherError.failure
        }
    }
}

enum WeatherError: Error {
    case wrongApi
    case failure
    case invalidCity
}
