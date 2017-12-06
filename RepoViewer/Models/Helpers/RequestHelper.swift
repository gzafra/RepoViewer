//
//  RequestHelper.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias ReposBlock = (Result<[RepoDTO]>)->()

final class RequestHelper {
    enum Keys: String {
        case accessToken = "access_token"
    }
    
    static func fetchRepos(with completionBlock: @escaping ReposBlock, page: Int = 1) {
        guard let url = Endpoint.repoList.url, let accessToken = ConfigValues.accessToken.string else {
            completionBlock(Result.failure(Errors.networkError(subType: .invalidRequest)))
            return
        }
        
        let parameters: Parameters = [accessToken: accessToken]

        Alamofire.request(url, method: .get, parameters: parameters).responseDecodableObject { (response: DataResponse<[RepoDTO]>) in
            guard let data = response.result.value else {
                completionBlock(Result.failure(Errors.networkError(subType: .invalidJson)))
                return
            }
            
            completionBlock(Result.success(data))
        }
    }
}
