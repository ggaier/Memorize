//
//  ArrayExt.swift
//  Memorize
//
//  Created by momo on 2021/3/3.
//

import Foundation

extension Array where Element: Identifiable {

    func firstIndex(of elem: Element) -> Int? {
        for i in 0..<count {
            if(self[i].id == elem.id) {
                return i
            }
        }
        return nil
    }
}
