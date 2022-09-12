//
//  RecipleaseSession.swift
//  Reciplease
//
//  Created by Déborah Suon on 06/05/2022.
//

import Foundation
import Alamofire

class RecipleaseSession: RecipleaseProtocol {
    func request(url: URL, completionHandler callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}
