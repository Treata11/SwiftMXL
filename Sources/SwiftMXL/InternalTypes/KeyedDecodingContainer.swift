//
//  KeyedDecodingContainer.swift
//
//
//  Created by Treata Norouzi on 10/5/23.
//

extension KeyedDecodingContainer {
    func count() -> Int {
        var count = 0
        for key in allKeys {
            if contains(key) {
                count += 1
            }
        }
        return count
    }
    
    // TODO: prematured-Optimizations required
    var indexedKeys: [Int: [CodingKey]] {
        var indexedKeys = [Int: [CodingKey]]()
        var index = 0
        for key in allKeys {
            if indexedKeys[index] == nil {
                  indexedKeys[index] = [CodingKey]()
              }
              indexedKeys[index]?.append(key)
              index += 1
        }
        return Dictionary(indexedKeys.sorted { $0.key < $1.key }, uniquingKeysWith: { $1 })
    }
}
