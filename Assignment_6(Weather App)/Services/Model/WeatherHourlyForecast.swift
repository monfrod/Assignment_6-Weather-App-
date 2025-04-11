//
//  WeatherHourlyForecast.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 10.04.2025.
//
import Foundation

// MARK: - Основная структура ответа
struct WeatherHourlyForecast: Decodable {
    let location: Location
    let current: CurrentWeatherHourlyForecast
    let forecast: Forecast
}

// MARK: - Местоположение
struct LocationHourlyForecast: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: - Текущая погода
struct CurrentWeatherHourlyForecast: Decodable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WeatherConditionHourlyForecast
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let windchillC: Double
    let windchillF: Double
    let heatindexC: Double
    let heatindexF: Double
    let dewpointC: Double
    let dewpointF: Double
    let visKm: Double
    let visMiles: Double
    let uv: Double
    let gustMph: Double
    let gustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Условия погоды
struct WeatherConditionHourlyForecast: Decodable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - Прогноз
struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

// MARK: - Прогноз на день
struct ForecastDay: Decodable {
    let date: String
    let dateEpoch: Int
    let day: DayForecast
    let astro: Astro
    let hour: [HourlyForecast]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Дневной прогноз
struct DayForecast: Decodable {
    let maxtempC: Double
    let maxtempF: Double
    let mintempC: Double
    let mintempF: Double
    let avgtempC: Double
    let avgtempF: Double
    let maxwindMph: Double
    let maxwindKph: Double
    let totalprecipMm: Double
    let totalprecipIn: Double
    let totalsnowCm: Double
    let avgvisKm: Double
    let avgvisMiles: Double
    let avghumidity: Double
    let dailyWillItRain: Int
    let dailyChanceOfRain: Int
    let dailyWillItSnow: Int
    let dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCm = "totalsnow_cm"
        case avgvisKm = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

// MARK: - Астрономические данные
struct Astro: Decodable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let moonIllumination: Int
    let isMoonUp: Int
    let isSunUp: Int
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Почасовой прогноз
struct HourlyForecast: Decodable, Identifiable {
    var id: Int { timeEpoch }
    
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WeatherConditionHourlyForecast
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let snowCm: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let windchillC: Double
    let windchillF: Double
    let heatindexC: Double
    let heatindexF: Double
    let dewpointC: Double
    let dewpointF: Double
    let willItRain: Int
    let chanceOfRain: Int
    let willItSnow: Int
    let chanceOfSnow: Int
    let visKm: Double
    let visMiles: Double
    let gustMph: Double
    let gustKph: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case snowCm = "snow_cm"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}
