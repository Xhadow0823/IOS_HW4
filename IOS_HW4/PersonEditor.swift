//
//  PersonEditor.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import SwiftUI

struct PersonEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var personData: PersonData
    
    var thePerson: Person?
    
    //==============================================
    @State private var personName = "YY"
    @State private var personRelation = "其他"
    @State private var personImp = false
    @State private var personPic = "0"
    //==============================================
    
    let relations: [String] = [
        "戀人", "同學", "同事", "上司", "其他", "爛人", "小三", "小王", "貓貓", "狗狗"
    ]
    let pNames: [String] = [
        "0", "1", "2", "D"
    ]
    
    var body: some View {
        Form{
            Section(header: Text("基本資料")){
                TextField("名稱", text: $personName)
                Picker("關係", selection: $personRelation){
                    ForEach(relations, id: \.self){
                        (relation) in
                        Text(relation)
                    }
                }.pickerStyle(WheelPickerStyle())
                Toggle("重要嗎？", isOn: $personImp)
            }
            Section(header: Text("顯示頭像")){
                VStack{
                    Image(personPic)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(Circle())
                    Picker("頭像", selection: $personPic){
                        ForEach(pNames, id: \.self){
                            (pName) in
                            Text(pName)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }// END Section
        }// END Form
        .navigationTitle(thePerson==nil ?"新增什麼人":"編輯什麼人")
        .navigationBarItems(trailing: Button("Save"){
            if let thePerson = thePerson{
                let index = self.personData.people.firstIndex{
                    $0.id == thePerson.id
                }!
                personData.people[index] = Person(name: personName, relation: personRelation, important: personImp, picName: personPic)
            }else{
                personData.people.insert(Person(name: personName, relation: personRelation, important: personImp, picName: personPic), at: 0)
            }
            presentationMode.wrappedValue.dismiss()
        })
        .onAppear(perform: {
            if let thePerson = thePerson {
                personName = thePerson.name
                personRelation = thePerson.relation
                personImp = thePerson.important
                personPic = thePerson.picName
            }
        })
        
    }
}

struct PersonEditor_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditor(personData: PersonData())
    }
}
