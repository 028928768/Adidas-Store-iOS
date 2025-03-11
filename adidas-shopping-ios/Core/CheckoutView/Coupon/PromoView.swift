//
//  PromoView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import SwiftUI

struct PromoView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            VStack {
                Group {
                    HStack {
                        Spacer()
                        Text("PROMO CODES")
                        
                        Spacer()
                        Button(action: {
                            isPresented.toggle()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                 
                    }
                } //: header
                .padding()
                
                Spacer()
            } //: Main VStack
        }
    }
}

#Preview {
    PromoView(isPresented: .constant(true))
}
