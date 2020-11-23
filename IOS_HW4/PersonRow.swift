//
//  PersonRow.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack{
            Image(person.picName)
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75, alignment: .center)
                .clipped()
                .clipShape(Circle())
                .padding(5)
                .overlay(Circle().stroke(person.important ? Color.red : Color.blue, lineWidth: 4))
                
            VStack(alignment: .leading){
                Text(person.name).bold()
                Text(person.relation)
            }
            Spacer()
            Button(action: {
//                var newPerson = person
//                newPerson.important.toggle()
//                let idx = personData.people.firstIndex{
//                    $0.id == person.id
//                }!
//                personData.people[idx] = newPerson
////                person.important.toggle()
            }, label: {
                Color.yellow
                    .frame(width: 50, height: 50)
                    .mask(
                        Image(systemName: person.important ?"star.fill":"star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    )
            })
            
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: Person(name: "Kenn", relation: "市長", important: false, picName: "D"))
            .previewLayout(.sizeThatFits)
    }
}
