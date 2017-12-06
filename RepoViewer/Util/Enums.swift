//
//  Enums.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Errors)
}

enum Endpoint: String {
    case repoList
    
    var url: String? {
        guard let baseUrl = ConfigValues.baseUrl.string,
            let availableEndPoints = ConfigValues.endpoints.dictionary,
            let endPoint = availableEndPoints[self.rawValue] else {
                return nil
        }
        return baseUrl + endPoint
    }
}
