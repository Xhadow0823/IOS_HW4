//
//  PersonData.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import Foundation
import SwiftUI

class PersonData: ObservableObject{
    @Published var people = [Person]()
    @AppStorage("people") var personData: Data?
    
    init(){
        if let personData = personData {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Person].self, from: personData) {
                people = decodedData
            }
        }
    }
}

class tmpPersonData: ObservableObject {
    @Published var people : [Person] = [
        Person(name: "KS", relation: "老王", important: false, picName: "D"),
        Person(name: "Jack", relation: "其他", important: false, picName: "0"),
        Person(name: "Dodo", relation: "愛人", important: true, picName: "1"),
        Person(name: "Caat", relation: "狗狗", important: true, picName: "2"),
    ]
}
