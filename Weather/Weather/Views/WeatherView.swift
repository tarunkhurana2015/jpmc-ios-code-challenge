//
//  ContentView.swift
//  Weather
//
//  Created by Tarun Khurana on 2/20/24.
//

import SwiftUI
import CoreLocation
import Combine

struct WeatherView: View {

    // MARK: Properties
    @State var viewModel: WeatherViewModel
    @State var location: CLLocation?
    var locationManager = LocationManager()

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        NavigationStack {
            // handling for the multiple devices orientation
            Group {
                // iPhione
                if horizontalSizeClass == .compact && verticalSizeClass == .regular ||
                    // iPad
                    horizontalSizeClass == .regular && verticalSizeClass == .regular {
                    weatherViewPortrait
                }
                // iPhone Landscape
                else if horizontalSizeClass == .compact && verticalSizeClass == .compact ||
                            horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    weatherViewLandscape
                }
            }
        }
        // Search bar
        .searchable(text: $viewModel.searchText, prompt: "Search by City, State")
        .onSubmit(of: .search) { // trigger the weather fetch with the search term
            Task {
                try? await viewModel.fetchWeatherForSearch()
            }
        }
        .task {
            // Check the user's location authorization on view appear
            await locationManager.checkAuthorization()
        }
        .onChange(of: locationManager.isAuthorized) { // listening to the location authorization change
            Task {
                // fetch the users current location
                location = try await locationManager.currentLocation
            }
        }
        .onChange(of: locationManager.isError) { _, newValue in // listening to the errors
            guard newValue else {
                return
            }
            // fetch the user's last stored location
            guard let coordinate = LocationStorage.getLocation() else {
                return
            }
            // fetch the weather
            runFetchWeatherTask(coordinate)
        }
        .onChange(of: location, { _, newValue in // listening to the location changes to fetch the weather with the new coordinates.
            guard let coordinate = newValue?.coordinate else { // location not found
                guard let coordinate = LocationStorage.getLocation() else { // get the user's last stored location
                    return
                }
                runFetchWeatherTask(coordinate)
                return
            }
            runFetchWeatherTask(Coordinate(lat: coordinate.latitude, lon: coordinate.longitude))
        })
    }

    var weatherViewLandscape: some View {
        HStack {
            weatherInnerView
        }
        .addDecoration()
    }

    var weatherViewPortrait: some View {
        VStack {
            weatherInnerView
        }
        .addDecoration()
    }

    var weatherInnerView: some View {
        Group {
            VStack(spacing: 1) {
                // Weather name
                Text(viewModel.weather?.name ?? "")
                    .bold()
                    .font(.title)
                    .padding(.top)
                // timezone
                if let timeZone = viewModel.weather?.timezone {
                    Text(timeZone.timeZoneOffsetToDateString())
                        .fontWeight(.light)
                }

                // Temp
                if let temp = viewModel.weather?.main.temp.roundDouble() {
                    Text(temp + "°")
                        .font(.system(size: 75))
                        .fontWeight(.bold)
                }
                // description
                Text("\(viewModel.weather?.weather.first?.description ?? "")")
                // high, low
                HStack {
                    if let highTemp = viewModel.weather?.main.tempMax.roundDouble() {
                        Text("H:\(highTemp)" + "°")
                    }
                    if let lowTemp = viewModel.weather?.main.tempMin.roundDouble() {
                        Text("L:\(lowTemp)" + "°")
                    }
                }
            }

            Spacer()

            // image display
            if let imageName = viewModel.weather?.weather.first?.icon {
                AyncImageView(url: "\(WeatherAPI.baseImageUrl)/\(imageName)@2x.png")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }

            // More Weather data display
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Condition")
                        .bold()
                        .padding(.bottom)

                    weatherDataView
                }
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.651, saturation: 0.687, brightness: 0.554))
                .background(.white)
                .cornerRadius(20)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    var weatherDataView: some View {
        Group {
            HStack {
                WeatherDataView(logo: "thermometer", name: "Min temp", value: (viewModel.weather?.main.tempMin.roundDouble() ?? "N/A") + "°")
                Spacer()
                WeatherDataView(logo: "thermometer", name: "Max temp", value: (viewModel.weather?.main.tempMax.roundDouble() ?? "N/A") + "°")
            }

            HStack {
                WeatherDataView(logo: "wind", name: "wind", value: (viewModel.weather?.wind.speed.roundDouble() ?? "N/A") + "m/s")
                Spacer()
                WeatherDataView(logo: "humidity", name: "humidity", value: (viewModel.weather?.main.humidity.roundDouble() ?? "N/A") + "%")
            }
        }
    }
}

struct DecorationModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(hue: 0.56, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
    }
}

extension View {
    func addDecoration() -> some View {
        modifier(DecorationModifier())
    }
}

extension WeatherView {
    func runFetchWeatherTask(_ coordinate: Coordinate) {
        Task {
            do {
                try await viewModel.fetchWeather(coordinate.lat, lon: coordinate.lon)
            }
            catch {
                Log.error("\(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService(urlFactory: WeatherURLFactory())))
}
