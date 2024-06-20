//
//  S05ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct S05ContentView: View {
    var body: some View {
        VStack {
            Button("Get Corrdinates") {
                Task {
                    let geocodingClient = GeocodingClient()
                    let location = try! await geocodingClient.coordinateByCity("ShangHai")
                    print(location)
                }
            }
        }.padding()
    }
}

struct S05ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S05ContentView()
    }
}
