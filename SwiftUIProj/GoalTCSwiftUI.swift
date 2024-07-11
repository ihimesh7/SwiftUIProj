//
//  GoalTCSwiftUI.swift
//  Hearty
//
//  Created by Himesh on 5/27/22.
//

import SwiftUI

struct GoalUnSelectedHeader : View {
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                Color(.blue)
                    .cornerRadius(16)
                HStack(alignment: .center) {
                    Image("ic_goal_target")
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    Text("Goal")
                        .font(Font.custom(FontName.poppinsSemiBold, size: 16))
                    Spacer()
                    Image("ic_arrow-down")
                        .padding(.leading, 0)
                        .padding(.trailing, 10)
                    
                }
                
            }
            .frame(height: 56.0)
            .padding(.bottom, 10)
            ZStack{
                Color(.blue)
                    .cornerRadius(16)
                HStack(alignment: .center) {
                    Image("ic_goal_target")
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    Text("Goal")
                        .font(Font.custom(FontName.poppinsSemiBold, size: 16))
                    Spacer()
                    Image("ic_arrow-down")
                        .padding(.leading, 0)
                        .padding(.trailing, 10)
                    
                }
                
            }
            .frame(height: 56.0)
            Color(.black)
        }
        .frame(height: 100)
        
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        GoalUnSelectedHeader()
    }
}

