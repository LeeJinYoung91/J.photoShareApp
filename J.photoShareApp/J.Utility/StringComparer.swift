//
//  StringComparer.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 31/10/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation

extension String {
    static func ==(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: .numeric) == .orderedSame
    }
    
    static func <(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: .numeric) == .orderedAscending
    }
    
    static func <=(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: .numeric) == .orderedAscending || lhs.compare(rhs, options: .numeric) == .orderedSame
    }
    
    static func >(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: .numeric) == .orderedDescending
    }
    
    static func >=(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: .numeric) == .orderedDescending || lhs.compare(rhs, options: .numeric) == .orderedSame
    }
}
