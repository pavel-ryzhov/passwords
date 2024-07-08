//
//  DependencyInjection.swift
//  passwords
//
//  Created by pavel on 01/07/2024.
//

import Resolver

extension Resolver : ResolverRegistering {
    private static let mainViewModel = MainViewModel()
    private static let passwordsDataSource = PasswordRecordDataDource()
    private static let authenticator = Authenticator()
    public static func registerAllServices() {
        register { passwordsDataSource }
        register { mainViewModel }
        register { authenticator }
    }
}
