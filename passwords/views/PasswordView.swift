//
//  PasswordView.swift
//  passwords
//
//  Created by pavel on 08/07/2024.
//

import SwiftUI

struct PasswordView: View {
    
    let model: PasswordRecordModel
    
    @State private var passwordVisible = false
    @State private var passwordVisibleWithAnimation = false
    
    var body: some View {
        VStack {
            Group {
                Text(model.login)
                HStack {
                    Text(getPasswordText()).font(passwordVisible ? .headline : .caption)
                    Spacer()
                    Image(systemName: !passwordVisibleWithAnimation ? "eye.slash" : "eye").padding(.trailing, 4)
                        .onTapGesture(perform: {
                            passwordVisible.toggle()
                            withAnimation {
                                passwordVisibleWithAnimation.toggle()
                            }
                        })
                }
                if let desc = model.desc {
                    Text(desc)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            .font(.headline)
            .overlay {
                RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1)
            }
        }
        .navigationTitle(model.getPreviewText())
        .padding()
        .padding(.top, 100)
        Spacer()
    }
    
    private func getPasswordText() -> String {
        //return passwordVisible ? model.password : String(repeating: "•", count: model.password.count)
        return passwordVisible ? model.password : String(repeating: "●", count: model.password.count)
    }
}

//#Preview {
    //PasswordView(PasswordRecordModel(context: NSManagedObjectContext(), login: "edede", password: "olped", description: nil))
//}
