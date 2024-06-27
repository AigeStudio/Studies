//
//  S06MVContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 27/6/2024.
//

import SwiftUI

struct S06MVContentView: View {
    @EnvironmentObject private var storeModel: StoreModel
    private func populateProducts() async {
        do {
            try await storeModel.populateProducts()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            List(storeModel.products) { product in
                Text(product.title)
                Text(product.price as NSNumber, formatter: NumberFormatter.currency)
            }
        }.task {
            await populateProducts()
        }.padding()
    }
}

#Preview {
    S06MVContentView().environmentObject(StoreModel(webservice: WebService()))
}
