//
//  ContentView.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var personData = PersonData()
    var body: some View {
        TabView{
            PersonList(personData: personData)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("對象清單")
                }
            ChartView(personData: personData)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("統計")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
