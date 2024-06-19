//
//  S04ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct S04ContentView: View {
    
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text(isOn ? "ON" : "OFF")
                    .foregroundStyle(.white)
            }.fixedSize()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isOn ? .yellow : .black)
    }
}

struct S04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S04ContentView()
    }
}
