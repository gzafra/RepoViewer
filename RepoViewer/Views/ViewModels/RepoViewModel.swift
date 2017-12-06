//
//  RepoViewModel.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import UIKit

struct RepoViewModel {
    let repoDTO: RepoDTO
    
    var name: String {
        return repoDTO.name
    }
    
    var description: String {
        return repoDTO.description
    }
    
    var owner: String {
        return "@\(repoDTO.ownerLogin)"
    }
    
    var backgroundColor: UIColor {
        return repoDTO.fork ? .green : .white
    }
}
