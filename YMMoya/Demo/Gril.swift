//
//  Gril.swift
//  YMMoya
//
//  Created by ym L on 2020/7/17.
//  Copyright © 2020 ym L. All rights reserved.
//

import Foundation
import HandyJSON

struct Girl: HandyJSON {
       var image: String?
    var title: String?
    var url: String?
    var publishedAt: String?
    var createdAt: String?
    var author: String?
    var category: String?
    var id: String?
    var desc: String?
    var type: String?
    var images: [String]?
    var stars: Int?
    var likeCounts: Int?
    var views: Int?
}
