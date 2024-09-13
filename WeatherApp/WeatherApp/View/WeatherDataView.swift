//
//  WeatherDataView.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import SwiftUI

struct WeatherDataView: View {
    
    @StateObject var viewModel: WeatherViewModel
    
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    Text(viewModel.dataModel?.name ?? "You Location")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                }
                
                HStack {
                    Text(viewModel.dataModel?.weather.first?.description.capitalized ?? "")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                    Text("\((viewModel.dataModel?.main.temp ?? 0).roundDouble()) °F")
                        .font(.title2)
                        .padding(.trailing, 30.0)
                        .foregroundColor(.white)
                    
                }
                
                Circle()
                    .foregroundColor(.white.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .background {
                        if let image = viewModel.imageIcon {
                            Image(uiImage: image)
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                        }
                    }
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    VStack(alignment: .leading, spacing: 20.0) {
                        WeatherSubView(name: "Feels Like",
                                       value: "\((viewModel.dataModel?.main.feelsLike ?? 0).roundDouble()) °F")
                        WeatherSubView(name: "Wind Speed",
                                       value: "\(viewModel.dataModel?.wind.speed ?? 0) m/hr")
                        
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .leading, spacing: 20.0) {
                        WeatherSubView(name: "Min",
                                       value: "\((viewModel.dataModel?.main.tempMin ?? 0).roundDouble()) °F")
                        WeatherSubView(name: "Max",
                                       value: "\((viewModel.dataModel?.main.tempMax ?? 0).roundDouble()) °F")
                        
                    }
                }
                .padding(.horizontal, 50.0)
                
                Spacer()
            }
        }.onAppear() {
            viewModel.getImage()
        }
    }
}


struct WeatherSubView: View {
    
    var name: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.caption)
                .foregroundStyle(.white)
            Text(value)
                .bold()
                .font(.title)
                .foregroundStyle(.white)
            
        }
    }
}


//#Preview {
//    WeatherDataView()
//}
