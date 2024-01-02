//
//  Service.swift
//  Weather Forecast App
//
//  Created by Eric Kazuo  on 31/12/23.
//

import Foundation

struct City {
    let lat: String
    let lon: String
    let name: String
}

class Service {
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let apiKey: String = "ca955657039463cbd15cfd9bf87b2bb5"
    private let session = URLSession.shared
    
    func fetchData(city: City, _ completion: @escaping (ForecastResponse?) -> Void) {
        //let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)&units=metric"
        let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&lang=pt_br&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, reponse, error in
            
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print(error)
                //print(String(data: data, encoding: .utf8) ?? "")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]

}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
        
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}


// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}


