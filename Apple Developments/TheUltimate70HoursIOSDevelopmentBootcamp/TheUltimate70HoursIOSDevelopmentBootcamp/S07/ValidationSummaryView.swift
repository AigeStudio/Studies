//
//  ValidationSummaryView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 30/6/2024.
//

import SwiftUI

struct ValidationSummaryView: View {
    let errors: [LocalizedError]
    var body: some View {
        ForEach(errors, id: \.id) { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    ValidationSummaryView(errors: [])
}
