//
//  Theme.swift
//  Concetration
//
//  Created by danni on 2022/03/29.
//

import Foundation
struct Theme
{
    var isFaceUP = false
    var isMatched = false
    var identifier: Int
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    //init(){
        //self.identifier = Card.getUniqueIdentifier()
    //}
}
