//
//  S06ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 21/6/2024.
//

import SwiftUI

struct S06ContentView: View {
    @StateObject private var vm = ProductListViewModel(webservice: WebService())
    var body: some View {
        List(vm.products) { product in
            Text(product.title)
        }.task {
            await vm.populateProducts()
        }
    }
}

#Preview {
    S06ContentView()
}
