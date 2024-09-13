//
//  TopView.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import SwiftUI

enum TopViewActions {
    case requestLocation
    case searchLocation(String)
}

struct TopView: View {
    
    var performAction: ((TopViewActions) -> Void)?
    
    @State private var textFieldText: String = ""
    
    var body: some View {
        HStack(spacing: 10.0) {
            // TextField
            TextField("Type your location here...", text: $textFieldText)
                .padding()
                .background(Color.white.opacity(1).cornerRadius(30))
                .foregroundColor(.red)
                .font(.headline)
            
            // Get Current Location
            Button(action: {
                if let action = performAction {
                    action(.requestLocation)
                }
            }, label: {
                Image(systemName: "location.square.fill")
                    .frame(width: 44, height: 44)
                    .scaledToFit()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.headline)
            })
            
            // Search by location name
            Button(action: {
                if let action = performAction {
                    action(.searchLocation(textFieldText))
                }
            }, label: {
                Text("Go".uppercased())
                    .frame(width: 44, height: 44)
                    .background(Color.mint)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.headline)
            })
        }
    }
}
#Preview {
    TopView()
}
