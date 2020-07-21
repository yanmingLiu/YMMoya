//
//  Response+HandyJson.swift
//  YMMoya
//
//  Created by ym L on 2020/7/17.
//  Copyright © 2020 ym L. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

// MARK: - Response Handlers
public extension Response {
    /// 整个 Data Model
    func mapObject<T: HandyJSON>(_: T.Type) -> T? {
        guard let dataString = try? mapString(),
            let object = JSONDeserializer<T>.deserializeFrom(json: dataString)
        else {
            return nil
        }
        return object
    }

    /// 制定的某个 Key 对应的模型
    func mapObject<T: HandyJSON>(_: T.Type, designatedPath: String) -> T? {
        guard let dataString = try? mapString(),
            let object = JSONDeserializer<T>.deserializeFrom(json: dataString, designatedPath: designatedPath)
        else {
            return nil
        }
        return object
    }

    /// Data 对应的 [Model]
    func mapArray<T: HandyJSON>(_: T.Type) -> [T?]? {
        guard let dataString = try? mapString(),
            let object = JSONDeserializer<T>.deserializeModelArrayFrom(json: dataString)
        else {
            return nil
        }
        return object
    }

    /// Data 某个Key 下对应的 的 [Model]
    func mapArray<T: HandyJSON>(_: T.Type, designatedPath: String) -> [T?]? {
        guard let dataString = try? mapString(),
            let object = JSONDeserializer<T>.deserializeModelArrayFrom(json: dataString, designatedPath: designatedPath)
        else {
            return nil
        }
        return object
    }
}
