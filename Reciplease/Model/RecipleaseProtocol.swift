//
//  RecipleaseProtocol.swift
//  Reciplease
//
//  Created by Déborah Suon on 06/05/2022.
//

import Foundation
import Alamofire


protocol RecipleaseProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void)
    
}

extension RecipleaseProtocol {
    var urlStringApi: String {
        "https://api.edamam.com/search?app_id=71985ae2&app_key=217d9cb0278c40857df1c5f46e2bec67&to=50&q="
    }
}
    
