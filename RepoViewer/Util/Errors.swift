//
//  Errors.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation

enum Errors: Error {
    case networkError(subType: NetworkErrors)
}

enum NetworkErrors: Error {
    case invalidRequest
    case invalidJson
}
