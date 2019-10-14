//
//  ContentView.swift
//  SliderGame
//
//  Created by 林伯翰 on 2019/10/14.
//  Copyright © 2019 林伯翰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var sliderValue = 50.0
    @State var alertVisible = false
    @State var targetValue = 0.0
    
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
            Text("移動滑桿到指定位置來獲取分數＾＾：\(targetValue)").modifier(labelStyle())
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
                                title: Text("title"),
                                message: Text("今天手感為：\(sliderValue).\n" +
                                    "本次的目標為：\(targetValue).\n" +
                                    "獲得的分數："),
                                dismissButton: .default(Text("Acknowledge!"))
                                )}
            Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.alertVisible = true
                    }){
                        Text("Reset Game").modifier(buttonSmallStyle())
                    }
                    Spacer()
                    Text("Score:").modifier(labelStyle())
                    Spacer()
                    Text("Round:").modifier(labelStyle())
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
    func awardValue(){
        
    }
    
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews:some View {
        ContentView().previewLayout(.fixed(width: 711, height: 400))
    }
}
