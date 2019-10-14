//
//  ContentView.swift
//  SliderGame
//
//  Created by 林伯翰 on 2019/10/14.
//  Copyright © 2019 林伯翰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var alertVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var round = 1
    @State var alertTitleStr = ""
    
    struct buttonLargeStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 26))
                .padding(10)
            
        }
    }
    struct buttonSmallStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 22))
                .overlay(
                    Capsule(style: .continuous)
                    .stroke(Color.white, lineWidth: 2)
                )
                .padding(10)
            
        }
    }
    
    struct labelStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .shadow(radius: 3)
                .font(Font.custom("Arial Rounded MT Bold", size: 26))
                .foregroundColor(Color.white)
        }
    }
    struct labelScoreStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .shadow(radius: 3)
                .font(Font.custom("Arial Rounded MT Bold", size: 26))
                .foregroundColor(Color.white)
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text("移動滑桿到指定位置來獲取分數：\(targetValue)").modifier(labelStyle())
            Spacer()
            
                HStack{
                    Text("1").modifier(labelScoreStyle())
                    Slider(value: $sliderValue, in: 1 ... 100)
                    Text("100").modifier(labelScoreStyle())
                }
                    Button(action: {
                        self.alertVisible = true
                    }){
                        Text("Hit ME!").modifier(buttonLargeStyle())
                    }.alert(isPresented: $alertVisible){ () -> Alert in
                        return Alert(
                                title: Text("\(alertTitleStr)"),
                                message: Text("今天手感為：\(sliderValueRounded()).\n" +
                                    "本次的目標為：\(targetValue).\n" +
                                    "獲得的分數：\(awardValue())"),
                                dismissButton: .default(Text("Acknowledge!")){
                                    self.totalScore += self.awardValue()
                                    self.targetValue = Int.random(in: 1 ... 100)
                                    self.round += 1
                                }
                                )}
            Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.resetGame()
                    }){
                        Text("Reset Game").modifier(buttonSmallStyle())
                    }
                    Spacer()
                    Text("Score:\(totalScore)").modifier(labelStyle())
                    Spacer()
                    Text("Round:\(round)").modifier(labelStyle())
                    Spacer()
                    Button(action: {
                        self.alertVisible = true
                    }){
                        Text("About Game").modifier(buttonSmallStyle())
                    }
                    Spacer()
                }
        }
        .background(Image("menu_bg"))
        .navigationBarTitle("Slider Game")
        
    }
    func numOffset() -> Int{
        return abs(targetValue - sliderValueRounded())
    }
    func sliderValueRounded() -> Int{
        return Int(sliderValue.rounded())
    }
    func awardValue() -> Int{
        let maximnmScore = 100
        var bonus = 0
        if numOffset() == 0{
            bonus = 100
            alertTitleStr = "哎呦～不錯嘛！"
        }else if numOffset() <= 1{
            bonus = 50
            alertTitleStr = "非常接近了!再努力一下！"
        }else if numOffset() <= 5{
            bonus = 20
            alertTitleStr = "稍微有點差距！"
        }else{
            bonus = 0
            alertTitleStr = "你確定你有用心？"
        }
        return maximnmScore - numOffset() + bonus
    }
    func resetGame(){
        self.targetValue = Int.random(in: 1 ... 100)
        self.round = 0
        self.totalScore = 0
        self.sliderValue = 50.0
    }
    
    
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews:some View {
        ContentView().previewLayout(.fixed(width: 711, height: 400))
    }
}
