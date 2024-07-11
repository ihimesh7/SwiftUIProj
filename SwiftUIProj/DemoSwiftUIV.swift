//
//  DemoSwiftUIV.swift
//  SwiftUIProj
//
//  Created by Himesh on 7/29/22.
//

import SwiftUI

struct DemoSwiftUIV: View {
    var textV: some View {
        VStack {
            Text("Hello")
                .foregroundColor(.white)
            Text("World!")
        }
        .font(.largeTitle)
    }
    var body: some View {
        ZStack(alignment: .center) {
            Color("PurpleBg_7B7FFF")
                .ignoresSafeArea()
            textV
                .padding()
                .background(Color.secondary)
                .cornerRadius(20)
        }
    }
}

struct DemoSwiftUIV_Previews: PreviewProvider {
    static var previews: some View {
        DemoSwiftUIV()
    }
}
