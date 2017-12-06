//
//  ConfigValues.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation

enum ConfigValues: String {
    case baseUrl = "BaseUrl"
    case accessToken = "AccessToken"
    case endpoints = "EndPoints"
    
    
    /// Returns a string value from the Info.plist for the specific config key
    var string: String? {
        guard let env = Bundle.main.infoDictionary,
            let configValue = env[self.rawValue] as? String else {
                return nil
        }
        return configValue
    }
    
    /// Returns a dictionary value from the Info.plist for the specific config key
    var dictionary: [String: String]? {
        guard let env = Bundle.main.infoDictionary,
            let configDict = env[self.rawValue] as? [String: String] else {
                return nil
        }
        return configDict
    }
}
