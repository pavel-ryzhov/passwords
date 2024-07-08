//
//  Authenticator.swift
//  passwords
//
//  Created by pavel on 08/07/2024.
//

import LocalAuthentication

@Observable
class Authenticator {
    
    var isAuthenticated = false
    
    func authenticate(reason: String) {
        isAuthenticated = false
        let context = LAContext()
        authenticate(.deviceOwnerAuthenticationWithBiometrics, context: context, reason: reason) { _ in
            self.authenticate(.deviceOwnerAuthentication, context: context, reason: reason) { authError in
                print("Authentication failed: \(authError?.localizedDescription ?? "Unknown error")")
            }
        }
        
    }
    
    private func authenticate(_ policy: LAPolicy, context: LAContext, reason: String, onFailure: @escaping (_ error: Error?) -> Void) {
        var error: NSError?
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: reason) { success, authError in
                if success {
                    self.isAuthenticated = true
                } else {
                    onFailure(authError)
                }
            }
        } else {
            onFailure(error)
        }
    }
}
