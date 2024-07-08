//
//  PasswordRecordModel.swift
//  passwords
//
//  Created by pavel on 28/06/2024.
//

import Foundation
import CoreData

@objc(PasswordRecordModel)
class PasswordRecordModel : NSManagedObject, Identifiable {
    //@NSManaged var id: UUID
    @NSManaged var login: String
    @NSManaged var password: String
    @NSManaged var desc: String?
    
//    convenience init? (login: String, password: String, description: String?) {
//        self.init(id: UUID(), login: login, password: password, description: description)
//    }
    
//    init? (id: UUID, login: String, password: String, description: String?) {
//        guard !login.isEmpty && !password.isEmpty else { return nil }
//        self.id = id
//        self.login = login
//        self.password = password
//        self.desc = description
//        
//    }
    
    convenience init?(context: NSManagedObjectContext, login: String, password: String, description: String?) {
        guard !login.isEmpty && !password.isEmpty else { return nil }
        //let entity = NSEntityDescription.entity(forEntityName: "PasswordRecordModel", in: context)
        self.init(context: context)
        self.login = login
        self.password = password
        self.desc = description
    }
    
//    convenience init?(context: NSManagedObjectContext, id: UUID, login: String, password: String, description: String?) {
//        guard !login.isEmpty && !password.isEmpty else { return nil }
//        //let entity = NSEntityDescription.entity(forEntityName: "PasswordRecordModel", in: context)
//        self.init(context: context)
//        self.id = id
//        self.login = login
//        self.password = password
//        self.desc = description
//    }
    
//    convenience init?(context: NSManagedObjectContext, login: String, password: String, description: String?) {
//        self.init(context: context, id: UUID(), login: login, password: password, description: description)
//    }
    
    func getPreviewText() -> String {
        return desc ?? login
    }
    
//    static let test: [PasswordRecordModel] = [
//        PasswordRecordModel(login: "login", password: "String", description: nil)!,
//        PasswordRecordModel(login: "login1", password: "passwod", description: "rkropkrpoe")!,
//        PasswordRecordModel(login: "login2", password: "passwod", description: "wrrwwr")!,
//        PasswordRecordModel(login: "login3", password: "passwod", description: "ww")!,
//        PasswordRecordModel(login: "login4", password: "passwod", description: "f")!,
//        PasswordRecordModel(login: "login5", password: "passwod", description: nil)!
//    ]
}
