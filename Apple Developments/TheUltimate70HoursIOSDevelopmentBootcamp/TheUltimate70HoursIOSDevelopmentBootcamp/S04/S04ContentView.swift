//
//  S04ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct S04ContentView: View {
    
    @State private var name: String = ""
    @State private var friends: [String] = []
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    friends.append(name)
                    name = ""
                }
            List(friends, id: \.self) { friend in
                Text(friend)
            }
            Spacer()
        }.padding()
    }
}

struct S04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S04ContentView()
    }
}
