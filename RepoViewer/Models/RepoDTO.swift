//
//  RepoDTO.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation
import CoreData

struct RepoDTO {
    let name: String
    let description: String?
    let ownerLogin: String
    let fork: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case owner
        case fork
    }
    
    enum OwnerKeys: String, CodingKey {
        case login
    }
}

extension RepoDTO: Decodable {
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try rootContainer.decode(String.self, forKey: .name)
        description = try? rootContainer.decode(String.self, forKey: .description)
        fork = try rootContainer.decode(Bool.self, forKey: .fork)
        let ownerContainer = try rootContainer.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
        ownerLogin = try ownerContainer.decode(String.self, forKey: .login)
    }
}

extension RepoDTO: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(fork, forKey: .fork)
        
        var ownerContrainer = container.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
        try ownerContrainer.encode(ownerLogin, forKey: .login)
        
    }
}

extension RepoDTO {
    enum CoreDataKeys: String {
        case name
        case repoDescription
        case owner
        case fork
    }
    
    @discardableResult
    func createManagedObject(forContext context: NSManagedObjectContext) -> NSManagedObject? {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Repo", into: context)
        entity.setValue(name, forKey: CoreDataKeys.name.rawValue)
        entity.setValue(description, forKey: CoreDataKeys.repoDescription.rawValue)
        entity.setValue(ownerLogin, forKey: CoreDataKeys.owner.rawValue)
        entity.setValue(fork, forKey: CoreDataKeys.fork.rawValue)
        return entity
    }
}
