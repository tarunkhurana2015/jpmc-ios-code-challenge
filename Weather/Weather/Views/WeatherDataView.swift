//
//  WeatherDataView.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import SwiftUI

struct WeatherDataView: View {

    let logo: String
    let name: String
    let value: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)

                Text(value)
                    .bold()
                    .font(.title)
            }
        }

    }
}

#Preview {
    WeatherDataView(logo: "", name: "feels like", value: "10")
}
