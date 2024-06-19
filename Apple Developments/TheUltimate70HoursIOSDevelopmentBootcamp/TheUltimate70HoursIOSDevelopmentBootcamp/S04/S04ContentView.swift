//
//  S04ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/19.
//

import SwiftUI

struct S04ContentView: View {
    @State private var search: String = ""
    @State private var friends: [String] = ["John", "Mary", "Steven", "Steve", "Jerry"]

    @State private var filteredFriends: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                List(filteredFriends, id: \.self) { friend in
                    Text(friend)
                }
                .listStyle(.plain)
                .searchable(text: $search)
                .onChange(of: search) { _ in
                    if search.isEmpty {
                        filteredFriends = friends
                    } else {
                        filteredFriends = friends.filter { $0.contains(search) }
                    }
                }
                Spacer()
            }.padding()
                .onAppear {
                    filteredFriends = friends
                }
                .navigationTitle("Friends")
        }
    }
}

struct S04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        S04ContentView()
    }
}
