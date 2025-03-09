//
//  SplashView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject private var viewModel = SplashViewModel()
    var body: some View {
            // content
            ZStack {
                if viewModel.isActive {
                    MainTabBarView()
                } else {
                    ZStack {
                        Image("adidas-logo")
                            .resizable()
                            .frame(width: 125, height: 100)
                            .scaledToFit()
                            .foregroundStyle(.tint)
                            .padding()
                        VStack {
                            Spacer()
                            ProgressView()
                        } //: VStack
                    } //: ZStack
                }
            } //: ZStack
            .onAppear {
                viewModel.manageSplashAction()
            }
            //: content
    }
}

#Preview {
    SplashView()
}
