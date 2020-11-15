//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/15.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Snow Seeker!")
                .font(.largeTitle)
            Text("Please select a resort from the left-hand menu.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

extension View {
    func phoneOnlyStackNavigationViw() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
