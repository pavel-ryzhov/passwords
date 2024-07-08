//
//  PasswordRecordDataDource.swift
//  passwords
//
//  Created by pavel on 01/07/2024.
//

import Foundation
import CoreData

@Observable
class PasswordRecordDataDource {
    
    let container: NSPersistentContainer
    
    init() {
        let entity = NSEntityDescription()
        entity.name = "PasswordRecordModel"
        entity.managedObjectClassName = String(describing: PasswordRecordModel.self)
        
        let loginAttr = NSAttributeDescription()
        loginAttr.name = "login"
        loginAttr.attributeType = .stringAttributeType
        loginAttr.isOptional = false
        
        let passwordAttr = NSAttributeDescription()
        passwordAttr.name = "password"
        passwordAttr.attributeType = .stringAttributeType
        passwordAttr.isOptional = false
        
        let descriptionAttr = NSAttributeDescription()
        descriptionAttr.name = "desc"
        descriptionAttr.attributeType = .stringAttributeType
        descriptionAttr.isOptional = true
        
        entity.properties = [loginAttr, passwordAttr, descriptionAttr]
        
        let model = NSManagedObjectModel()
        model.entities = [entity]
        
        container = NSPersistentContainer(name: "passwords", managedObjectModel: model)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading persistent store: \(error)")
            }
        }
    }
    
    func fetchModels() -> [PasswordRecordModel] {
        let request = NSFetchRequest<PasswordRecordModel>(entityName: "PasswordRecordModel")
        var result: [PasswordRecordModel] = []
        do {
            result = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching models: \(error)")
        }
        return result
    }
    
    func deleteModel(_ entity: PasswordRecordModel) -> Bool {
        container.viewContext.delete(entity)
        return saveModels()
    }
    
    func addModel(login: String, password: String, description: String?) -> Bool {
        return PasswordRecordModel(context: container.viewContext, login: login, password: password, description: description) != nil && saveModels()
    }
    
    private func saveModels() -> Bool {
        do {
            try container.viewContext.save()
            return true
        } catch let error {
            print("Error saving models: \(error)")
            return false
        }
    }
}
