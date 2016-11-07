//
//  WSModelJSONParser.swift
//  ws
//
//  Created by Sacha Durand Saint Omer on 06/04/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation
import Arrow

open class WSModelJSONParser<T:ArrowParsable> {
    
    public init() { }
    
    open func toModel(_ json: JSON, keypath: String?) -> T {
        let data = resourceData(from: json, keypath: keypath)
        return resource(from: data)
    }
    
    open func toModels(_ json: JSON, keypath: String?) -> [T] {
        guard let array = resourceData(from: json, keypath: keypath).collection else {
            return [T]()
        }
        return array.map { resource(from: $0) }
    }
    
    private func resource(from json: JSON) -> T {
        var t = T()
        t.deserialize(json)
        return t
    }
    
    private func resourceData(from json: JSON, keypath: String?) -> JSON {
        if let k = keypath, !k.isEmpty, let j = json[k] {
            return j
        }
        return json
    }
    
}
