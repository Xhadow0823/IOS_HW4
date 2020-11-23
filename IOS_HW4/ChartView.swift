//
//  ChartView.swift
//  IOS_HW4
//
//  Created by 翁星宇 on 2020/11/16.
//

import SwiftUI

let relations: [String] = [
    "戀人", "同學", "同事", "上司", "其他", "爛人", "小三", "小王", "貓貓", "狗狗"
]
let colors = [
    Color.red,
    Color.blue,
    Color.green,
    Color.yellow,
    Color.gray,
    Color.pink,
    Color.purple,
    Color.orange,
    Color(red: 158.0/255, green: 168.0/255, blue: 50.0/255),
    Color(red: 168.0/255, green: 50.0/255, blue: 85.0/255)
]

let charts = ["圓餅圖", "長條圖"]

struct ChartView: View {
    var staticData: [Double] = [0, 0, 0, 0, 0,   0, 0, 0, 0, 0]
    var pieAngles = [Angle]()
    var total = 0.0
    
    
    @ObservedObject var personData = PersonData()
    @State private var chartSelected = 1  //0: pieChart, 1: histoGram
    
    init(personData: PersonData){
        for person in personData.people{
            let index = relations.firstIndex{
                $0 == person.relation
            }!
            staticData[index] += 1
            total += 1
        }
        var angleCount = 0.0
        for idx in 0..<9{
            angleCount += staticData[idx]/total * 360.0
            pieAngles.append(Angle.degrees(angleCount))
        }
    }
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                if(chartSelected == 0){
                    PieChartView(angles: pieAngles)
                        .frame(width: 250, height: 250)
                }else if(chartSelected == 1){
                    HistoGramView(staticsData: staticData, total: total)
                }
                Text("Total: \(Int(total))").bold()
                HStack{
                    VStack{
                        ForEach(0..<5){
                            (idx) in
                            HStack{
                                colors[idx].frame(width: 15, height: 15)
                                Text("\(relations[idx]) \(staticData[idx]/total * 100)%")
                            }
                        }
                    }
                    VStack{
                        ForEach(5..<10){
                            (idx) in
                            HStack{
                                colors[idx].frame(width: 15, height: 15)
                                Text("\(relations[idx]) \(staticData[idx]/total * 100)%")
                            }
                        }
                    }
                }  // End HStack
                Picker(selection: $chartSelected, label: Text("請選擇項目：")) {
                    ForEach(0..<2){
                        (idx) in
                        Text("\(charts[idx])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)
                .padding(.bottom, 100)
            }  // End VStack
            .navigationTitle(total==0 ?"還沒有資料喔":"統計數據")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(personData: PersonData())
//        HistoGramView(staticsData: [1, 2, 3], total: 6)
    }
}

// =====================================================

struct HistoGramView : View {
    var staticsData: [Double]
    var total = 0.0
    var body: some View {
        VStack {
            HStack (alignment: .bottom){
                ForEach(staticsData.indices){
                    (idx) in
                    VStack {
                        Rectangle()
                            .fill(colors[idx])
                            .frame(
                                width: 20, height: CGFloat(250 * staticsData[idx] / total))
                            .animation(.linear(duration: 0.8))
                        Text("\(Int(staticsData[idx]))")
                    }
                }
            }  //END HStack
        }  //END VStack
    }
}


// =====================================================
struct PieChartView: View {
    var angles: [Angle]
    var body: some View {
        ZStack{
            PieChart(start: .degrees(0), end: angles[0])
                .fill(Color.red)
            ForEach(0..<8){
                (i) in
                PieChart(start: angles[i], end: angles[i+1])
                    .fill(colors[i+1])
            }
            PieChart(start: angles[8], end: .degrees(360))
                .fill(Color(red: 168.0/255, green: 50.0/255, blue: 85.0/255))
        }
    }
}

struct PieChart: Shape {
    var start: Angle
    var end: Angle
    func path(in rect: CGRect) -> Path {
        Path { (path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX,
                        startAngle: start, endAngle: end, clockwise: false)
        }
    }
}

