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
    @State var roundValue = 1
    
    
    struct buttonLargeStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 26))
                .overlay(
                    Capsule(style: .continuous)
                    .stroke(Color.white, lineWidth: 2)
                )
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
                .foregroundColor(Color.yellow)
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
                                title: Text("\(alertTitle())"),
                                message: Text("今天手感為：\(sliderValueRounded()).\n" +
                                    "本次的目標為：\(targetValue).\n" +
                                    "獲得的分數：\(awardValue())"),
                                dismissButton: .default(Text("Acknowledge!")){
                                    self.totalScore += self.awardValue()
                                    self.targetValue = Int.random(in: 1 ... 100)
                                    self.roundValue += 1
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
                    Text("Score:").modifier(labelStyle())
                    Text("\(totalScore)").modifier(labelScoreStyle())
                    
                    Spacer()
                    Text("Round:\(roundValue)").modifier(labelStyle())
                    //Text("\(roundValue)")

                    Spacer()
                        NavigationLink(destination: AboutViews()){
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
        }else if numOffset() <= 1{
            bonus = 50
        }else if numOffset() <= 5{
            bonus = 20
        }else{
            bonus = 0
        }
        return maximnmScore - numOffset() + bonus
    }
    func alertTitle() -> String{
        
        let title: String
        if numOffset() == 0{
            title = "哎呦～不錯嘛！"
        }else if numOffset() <= 1{
            title = "非常接近了!再努力一下！"
        }else if numOffset() <= 5{
            title = "稍微有點差距！"
        }else{
            title = "你確定你有用心？"
        }
        return title
    }
    
    func resetGame(){
        self.targetValue = Int.random(in: 1 ... 100)
        self.roundValue = 0
        self.totalScore = 0
        self.sliderValue = 50.0
    }
    
    
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews:some View {
        ContentView().previewLayout(.fixed(width: 711, height: 400))
    }
}
