//
//  AboutViews.swift
//  SliderGame
//
//  Created by 林伯翰 on 2019/10/14.
//  Copyright © 2019 林伯翰. All rights reserved.
//

import SwiftUI

struct AboutViews: View {
    let bgColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct HeadingViewsStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom,20)
        }
    }
    struct TextViewsStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom,20)
        }
    }
    
    var body: some View {
        VStack{
            Group{
                VStack{
                    VStack{
                        Text("🔑 Slider Game 🔑").modifier(HeadingViewsStyle())
                    }
                    Text("這是一個滑感遊戲，每次使用滑桿滑到該目標值，來獲取分數。").modifier(TextViewsStyle()).lineLimit(nil)
                    VStack{
                        Text("Enjoy Your Game!").modifier(TextViewsStyle())
                    }
                    
                    
                }
                .background(bgColor)
                .navigationBarTitle("關於 Slider Game")
            }
            
        }.background(Image("menu_bg"),alignment: .center)
    }
}

struct AboutViews_Previews: PreviewProvider {
    static var previews: some View {
        AboutViews().previewLayout(.fixed(width: 711, height: 400))
    }
}
