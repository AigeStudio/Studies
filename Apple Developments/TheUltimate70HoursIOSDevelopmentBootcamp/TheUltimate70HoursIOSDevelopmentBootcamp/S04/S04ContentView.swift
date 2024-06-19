//
//  S04ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

// Pre IOS 17
class AppState: ObservableObject {
    @Published var isOn: Bool = false
}

struct LightBulbView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack {
            Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb")
                .font(.largeTitle)
                .foregroundStyle(appState.isOn ? .yellow : .black)
            Button("Toggle") {
                appState.isOn.toggle()
            }
        }
    }
}

struct LightRoomView: View {
    var body: some View {
        LightBulbView()
    }
}

struct S04ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack {
            LightRoomView()
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(appState.isOn ? .black : .white)
    }
}

struct S04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S04ContentView()
            .environmentObject(AppState())
    }
}
