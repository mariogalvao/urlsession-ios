//
//  Pet.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import Foundation

class Pet: Codable {
    
    public enum Status: String, Codable {
        case available = "available"
        case pending = "pending"
        case sold = "sold"
    }
    public var _id: Int64?
    public var category: Category?
    public var name: String
    public var photoUrls: [String]
    public var tags: [Tag]?
    /** pet status in the store */
    public var status: Status?

    public init(_id: Int64?, category: Category?, name: String, photoUrls: [String], tags: [Tag]?, status: Status?) {
        self._id = _id
        self.category = category
        self.name = name
        self.photoUrls = photoUrls
        self.tags = tags
        self.status = status
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case category
        case name
        case photoUrls
        case tags
        case status
    }
    
}
