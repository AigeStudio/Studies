//
//  S04ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct LightBulbView: View {
    
    @Binding var isOn: Bool

    var body: some View {
        VStack {
            Image(systemName: isOn ? "lightbulb.fill" : "lightbulb")
                .font(.largeTitle)
                .foregroundStyle(isOn ? .yellow : .black)
            Button("Toggle") {
                isOn.toggle()
            }
        }
    }
}

struct S04ContentView: View {
    
    @State private var isLightOn: Bool = false
    
    var body: some View {
        VStack {
            LightBulbView(isOn: $isLightOn)
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isLightOn ? .black : .white)
    }
}

struct S04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S04ContentView()
    }
}
