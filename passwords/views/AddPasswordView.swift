//
//  AddPasswordView.swift
//  passwords
//
//  Created by pavel on 01/07/2024.
//

import SwiftUI
import Resolver

struct AddPasswordView: View {
    
    @Injected var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var login = ""
    @State private var password = ""
    @State private var description = ""
    @State private var passwordVisible = false
    @State private var passwordVisibleWithAnimation = false
    @FocusState private var fieldFocus: Focus?
    
    
    private func chooseFocusForPasswordField() -> Focus {
        return passwordVisible ? .plain : .secure
    }
    
    private func getEyeView() -> some View {
        HStack {
            Spacer()
            Image(systemName: !passwordVisibleWithAnimation ? "eye.slash" : "eye").padding(.trailing, 4)
                .onTapGesture(perform: {
                    passwordVisible.toggle()
                    withAnimation {
                        passwordVisibleWithAnimation.toggle()
                    }
                    if fieldFocus != nil {
                        fieldFocus = chooseFocusForPasswordField()
                    }
                })
        }
    }
    
    private func configurePasswordField(_ field: some View) -> some View {
        return field
            .focused($fieldFocus, equals: field is SecureField<Text> ? .secure : .plain)
            .overlay(content: getEyeView)
            .submitLabel(.next)
            .onSubmit {
                fieldFocus = .description
            }
    }
    
    private func addData() {
        if login.isEmpty {
            fieldFocus = .login
            return
        }
        if password.isEmpty {
            fieldFocus = chooseFocusForPasswordField()
            return
        }
        viewModel.addPasswordModel(login: login, password: password, description: description.isEmpty ? nil : description)
        presentationMode.wrappedValue.dismiss()
    }
    
    private enum Focus {
        case secure, plain
        case login, description
    }

    var body: some View {
        VStack {
            Group {
                TextField("Login", text: $login)
                    .submitLabel(.next)
                    .onSubmit {
                        fieldFocus = chooseFocusForPasswordField()
                    }
                if passwordVisible {
                    configurePasswordField(TextField("Password", text: $password))
                } else {
                    configurePasswordField(SecureField("Password", text: $password))
                }
                TextField("Description (optional)", text: $description)
                    .focused($fieldFocus, equals: .description)
                    .submitLabel(.done)
                    .onSubmit(addData)
            }
            .font(.headline)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1)
            }
            Button("Submit", action: addData)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.white)
                .background {
                    Color.accentColor.cornerRadius(4)
                }
                .padding(.top)
        }
        .navigationTitle("Add password")
        .padding()
        .padding(.top, 100)
        Spacer()
    }
}

#Preview {
    AddPasswordView()//.environment(MainViewModel())
}
