//
//  PersonList.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import SwiftUI

struct PersonList: View {
    @ObservedObject var personData = PersonData()
    @State private var showEditor: Bool = false
    @State private var target: String = ""
    
    var filtedPersonData: [Person] {
        return personData.people.filter({target.isEmpty ? true : $0.name.contains(target)})
    }
    
    var body: some View {
        NavigationView{
            List{
                TextField("尋找對象", text: $target)
                ForEach(filtedPersonData){  //ForEach(personData.people){
                    (person) in
                    NavigationLink(
                        destination: PersonEditor(personData: personData, thePerson: person),
                        label: {
                            PersonRow(person: person)
                        })
                }
                .onMove{
                    (idxSet, idx) in
                    personData.people.move(fromOffsets: idxSet, toOffset: idx)
                }
                .onDelete{
                    (idxSet) in
                    personData.people.remove(atOffsets: idxSet)
                }
            }
            .navigationTitle("約會對象")
            .navigationBarItems(leading: Button("New"){
                showEditor = true
            }.disabled(personData.people.count >= 99)
            , trailing: EditButton())
            .sheet(isPresented: $showEditor){
                NavigationView{
                    PersonEditor(personData: personData)
                }
            }
        }
        
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList()
    }
}

