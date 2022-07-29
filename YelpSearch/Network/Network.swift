//
//  Network.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

fileprivate struct APIKeys {
    static let apiPrivateKey = "zgiRQaO_DK6zjXp6AmDF9PbVRMH1krV8nc3rX7l-DAJm1Wbv_sHUdyy4p9inVa_G_hZn37-cbUN5iNUrNeeWuWA9tlD0cM1qiropCx-N7jCJI24CpPYDlr1LApfiYnYx"
}

final class Network<T: Decodable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    private let header: HTTPHeaders
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: .background, relativePriority: 1))
        self.header = HTTPHeaders(["Authorization": "Bearer \(APIKeys.apiPrivateKey)"])
    }
    
    func getItem<E>(_ path: String, request: E) -> Observable<T> where E: Codable {
        let absolutePath = "\(endPoint)/\(path)"
        let parameter = request.jsonDict
        return RxAlamofire
            .data(.get, absolutePath, parameters: parameter, headers: header)
            .debug("Get item \(T.self) with \(path) and parameters: \(parameter ?? [:])")
            .observe(on: scheduler)
            .map({ data -> T in
            return try JSONDecoder().decode(T.self, from: data)
        })
    }
    
}
