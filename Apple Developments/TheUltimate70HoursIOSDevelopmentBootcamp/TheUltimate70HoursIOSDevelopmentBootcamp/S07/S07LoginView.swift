//
//  S07ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 27/6/2024.
//

import SwiftUI

struct LoginState {
    var email: String = ""
    var password: String = ""
    var emailError: LoginError?
    var passwordError: LoginError?

    mutating func clearErrors() {
        emailError = nil
        passwordError = nil
    }

    mutating func isValid() -> Bool {
        clearErrors()
        if email.isEmpty {
            emailError = LoginError.emailEmpty
        } else {
            emailError = LoginError.emailInvalid
        }
        if password.isEmpty {
            passwordError = LoginError.passwordEmpty
        }
        return emailError == nil && passwordError == nil
    }
}

struct S07LoginView: View {
    @State private var loginState = LoginState()

    var body: some View {
        Form {
            TextField("Email", text: $loginState.email)
                .textInputAutocapitalization(.never)
            if let emailError = loginState.emailError {
                Text(emailError.localizedDescription)
                    .font(.caption)
            }
            SecureField("Password", text: $loginState.password)
            if let passwordError = loginState.passwordError {
                Text(passwordError.localizedDescription)
                    .font(.caption)
            }
            Button("Login") {
                if loginState.isValid() {}
            }
//            ValidationSummaryView(errors: errors)
        }
    }
}

#Preview {
    S07LoginView()
}
