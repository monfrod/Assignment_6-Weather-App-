//
//  MainView.swift
//  Assignment_6(Weather App)
//
//  Created by yunus on 09.04.2025.
//
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            backgroundForConditionIcon(viewModel.mainInfo?.status ?? "")
                .ignoresSafeArea()
            
            ScrollView {
                mainInfoView(info: viewModel.mainInfo ?? MainInfo(city: "Almaty", temp: 999, status: "error"))
                hourlyForecast(forecast: viewModel.hourlyForecast)
                TenDayForecastView(forecast: viewModel.tenDayForecast)
            }
        }
        .task {
//            await viewModel.fetchCurrentWeather(city: "Almaty")
//            await viewModel.fetchHourlyForecast(city: "Almaty")
//            viewModel.iconCalculate()
            await viewModel.fetchAllWeather(city: "Almaty")
            print(viewModel.currentConditionIcon)
        }
    }
    
    @ViewBuilder
    func mainInfoView(info: MainInfo) -> some View {
        VStack {
            Text(info.city)
                .font(.system(size: 40))
                .fontWeight(.light)
                .foregroundStyle(.white)
                .padding(.top, 50)
            Text("\(Int(info.temp))°")
                .font(.system(size: 100))
                .foregroundStyle(.white)
                .fontWeight(.thin)
            Text(info.status)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
    
    func hourlyForecast(forecast: [HourlyForecast]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "clock")
                Text("Hourly Forecast")
            }
            .padding(.leading, 20)
            .foregroundStyle(.gray)
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(forecast, id: \.id) { hour in
                        HourlyForecastCell(hour: hour)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(.thinMaterial)
        .background(.gray)
        .cornerRadius(20)
        .padding()
    }
    
    @ViewBuilder
    func backgroundForConditionIcon(_ text: String) -> some View {
        if text.contains("night") {
            Image("nightWallpaper")
                .resizable()
                .scaledToFill()
        } else if text.contains("113") {
            Image("sunnyWallpaper")
                .resizable()
                .scaledToFill()
        } else if text.contains("cloudy") {
            Image("cloudWallpaper")
                .resizable()
                .scaledToFill()
        } else if text.contains("rain") {
            Image("rainWallpaper")
                .resizable()
                .scaledToFill()
        }
    }
    
    struct HourlyForecastCell: View {
        let hour: HourlyForecast
        
        var body: some View {
            VStack(spacing: 8) {
                Text("\(Int(hour.tempC))°")
                    .font(.system(size: 15))
                    .foregroundColor(.white)

                AsyncImage(url: URL(string: "https:\(hour.condition.icon)"))
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)

                Text(formatHour(from: hour.time))
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
    
}

func formatHour(from timeString: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    if let date = formatter.date(from: timeString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        return outputFormatter.string(from: date)
    }
    return timeString
}

struct TenDayForecastView: View {
    let forecast: [TenDayForecast] // модель из твоего ответа API
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "clock")
                Text("10 Day Forecast")
            }
            .padding(.leading, 20)
            .foregroundStyle(.gray)
            Divider()
            ForEach(forecast, id: \.id) { day in
                HStack {
                    // День недели
                    Text(day.day)
                        .frame(width: 50, alignment: .leading)
                        .foregroundColor(.white)
                    
                    // Иконка погоды
                    AsyncImage(url: URL(string: "https:\(day.icon)")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 25, height: 25)

                    Spacer().frame(width: 40)

                    // Минимальная и максимальная температура
                    Text("\(day.minTemp)°")
                        .frame(width: 30, alignment: .trailing)
                        .foregroundColor(.white)
                    
                    GeometryReader { geometry in
                        let total = CGFloat(day.maxTemp - day.minTemp)
                        let filled = CGFloat(geometry.size.width * (1 - total / 40))
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [.cyan, .yellow], startPoint: .leading, endPoint: .trailing))
                            .frame(width: filled, height: 6)
                            .padding(.horizontal)
                    }
                    .frame(height: 6)
                    
                    Text("\(day.maxTemp)°")
                        .frame(width: 30, alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(.thinMaterial)
        .background(.gray)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    func dayLabel(for dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateStr) else { return "" }

        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else {
            formatter.dateFormat = "E"
            return formatter.string(from: date)
        }
    }
}
//#Preview {
//    MainView()
//}
