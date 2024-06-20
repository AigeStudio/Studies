//
//  S05ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct S05ContentView: View {
    @State private var city: String = ""
    @State private var isFetchingWeather: Bool = false

    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()

    @State private var weather: Weather?

    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            TextField("City", text: $city)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isFetchingWeather = true
                }.task(id: isFetchingWeather) {
                    if isFetchingWeather {
                        await fetchWeather()
                        isFetchingWeather = false
                        city = ""
                    }
                }
            Spacer()
            if let weather {
                Text(MeasurementFormatter.temperature(value: weather.temp))
                    .font(.system(size: 100))
            }
            Spacer()
        }.padding()
    }
}

struct S05ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S05ContentView()
    }
}
