//
//  MainView.swift
//  passwords
//
//  Created by pavel on 28/06/2024.
//

import SwiftUI
import Resolver

struct MainView: View {

    @Injected var viewModel: MainViewModel
    @Injected var authenticator: Authenticator
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationView {
            if authenticator.isAuthenticated {
                List {
                    ForEach(viewModel.models) { model in
                        Text(model.getPreviewText())
                    }
                    .onDelete(perform: viewModel.deletePasswordModel)
                }
                .navigationTitle("Passwords")
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                .toolbar {
                    NavigationLink(destination: { AddPasswordView() }, label: {
                        Image(systemName: "plus")
                    })
                }
            } else {
                VStack {
                    Text("Authenticate to access your passwords!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("Tap to retry")
                        .font(.callout)
                }
                .onTapGesture(perform: authenticate)
                
            }
        }
        .onAppear(perform: authenticate)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                authenticator.isAuthenticated = false
            }
            if oldPhase == .background && newPhase == .inactive {
                authenticate()
            }
        }
    }
    
    private func authenticate() {
        authenticator.authenticate(reason: "Authenticate to access your passwords")
    }
}

#Preview {
    MainView()
}
