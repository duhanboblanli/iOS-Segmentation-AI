//
//  WeatherView.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 5.11.2023.
//


import SwiftUI

struct WeatherResponse: Decodable {
    var main: Main
    
    struct Main: Decodable {
        var tempMin: Double
        var tempMax: Double
    }
}

struct WeatherView: View {
    @State private var minTemp: String = ""
    @State private var maxTemp: String = ""
    
    var body: some View {
        VStack {
            Text("Min Temp: \(minTemp)")
            Text("Max Temp: \(maxTemp)")
        }
        .onAppear {
            getWeatherData()
        }
    }
    
    fileprivate func getWeatherData() {
        
        // Do any additional setup after loading the view.
        var url = URL(string: "https://api.openweathermap.org/data/2.5/weather")
        
        url?.append(queryItems: [
            URLQueryItem(name: "lat", value: "28.7041"),
            URLQueryItem(name: "lon", value: "77.1025"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem.init(name: "appid", value: "26f1ffa29736dc1105d00b93743954d2"),
        ])
        
        print("URL:",url!)
        NetworkManager.shared.afRequest(url: url, expecting: WeatherResponse.self) { data, error in
            if let error {
                
                print("NetworkManager Error:",error.localizedDescription)
                return
            }
            
            if let data {
                print("Data:",data)
                print("Min Temp:",data.main.tempMin)
                minTemp = "\(data.main.tempMin)"
                maxTemp = "\(data.main.tempMax)"
            }
        }
    }
    
}

