//
//  API.swift
//  YMMoya
//
//  Created by ym L on 2020/7/17.
//  Copyright © 2020 ym L. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

let provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [loggerPlugin])

enum API {
    case banners
    case girls(params: [String: Any])
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://gank.io/api/v2")!
    }

    var path: String {
        switch self {
        case .banners:
            return "/banners"
        case .girls:
            return "/data/category/Girl/type/Girl/page/1/count/10"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        case let .girls(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
