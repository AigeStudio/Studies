//
//  S07ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 27/6/2024.
//

import SwiftUI

struct S07LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty && email.isValidEmail
    }

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("Login") {}.disabled(!isFormValid)
        }
    }
}

#Preview {
    S07LoginView()
}
