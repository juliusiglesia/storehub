//
//  ModalView.swift
//  storehub
//
//  Created by Julius Iglesia on 29/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct Modal<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        NavigationView {
            self.content()
            .navigationBarItems(leading:
                Button("close") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
