//
//  MainViewModel.swift
//  passwords
//
//  Created by pavel on 01/07/2024.
//

import Foundation
import Resolver

@Observable
class MainViewModel {

    @ObservationIgnored
    @Injected var dataSource: PasswordRecordDataDource
    var models: [PasswordRecordModel] = []
    
    init() {
        models = dataSource.fetchModels()
    }
    
    func addPasswordModel(login: String, password: String, description: String?) {
        if dataSource.addModel(login: login, password: password, description: description) {
            models = dataSource.fetchModels()
        }
    }
    
    func deletePasswordModel(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        if dataSource.deleteModel(models[index]) {
            models.remove(at: index)
        }
    }
}
