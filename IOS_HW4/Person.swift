//
//  Person.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import Foundation

struct Person : Identifiable, Codable{
    var id = UUID()
    var name: String
    var relation: String = "其他"
    var important: Bool = false
    var picName: String = "0"
}
