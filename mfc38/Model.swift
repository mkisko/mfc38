//
//  Model.swift
//  mfc38
//
//  Created by Алексей Усанов on 27.07.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import Foundation
import CoreData
import SystemConfiguration

class News {
    var question: String
    var answer: String
    
    init (question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

class QA {
    var question: String
    var answer: String
    
    init (question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

class Office {
    var area: String?
    var address: String?
    var latitude: Double
    var longitude: Double
    var monday: String?
    var tuesday: String?
    var wednesday: String?
    var thursday: String?
    var friday: String?
    var saturday: String?
    var busy: String?
    var boss: String?
    
    var eo: Bool
    var ik: Bool
    var atm: Bool
    var photobootch: Bool
    var idea2business: Bool
    
    init (area: String, address: String, latitude: Double, longitude: Double, monday: String, tuesday: String, wednesday: String, thursday: String, friday: String, saturday: String, boss: String, busy: String, eo: Bool, ik: Bool, atm: Bool, photobootch: Bool, idea2business: Bool) {
        
        self.area = area
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.busy = busy
        self.boss = boss
        
        self.eo = eo
        self.ik = ik
        self.atm = atm
        self.photobootch = photobootch
        self.idea2business = idea2business
    }
}

    class OfficeDist {
        var office: String
        var dist: Double
        
        init(office: String, dist: Double) {
            self.office = office
            self.dist = dist
        }
        
    }

public class BinarySearchTree<T: Any> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
   
    
}


