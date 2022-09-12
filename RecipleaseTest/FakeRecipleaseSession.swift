//
//  FakeRecipleaseSession.swift
//  RecipleaseTest
//
//  Created by Déborah Suon on 07/06/2022.
//

import Foundation
import Alamofire
@testable import Reciplease

class FakeRecipleaseSession: RecipleaseProtocol {
    
    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        completionHandler(dataResponse)
    }
    
    
}
