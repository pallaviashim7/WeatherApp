//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import SwiftUI

struct ErrorView: View {
    var errorTitle: String?
    
    var body: some View {
        Text(errorTitle ?? "Something went wrong try with a new location")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(.white)
    }
}


#Preview {
    ErrorView()
}
