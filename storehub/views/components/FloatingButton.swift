//
//  FloatingButton.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct FloatingButtonOptions: Hashable {
    var id: String
    var icon: String
    var action: () -> Void
    
    static func == (lhs: FloatingButtonOptions, rhs: FloatingButtonOptions) -> Bool {
        return lhs.id == rhs.id && lhs.icon == rhs.icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(icon)
    }
}

struct FloatingButton: View {
    @State private var showFabMenu = false
    
    var options: Array<FloatingButtonOptions> = []

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    if self.showFabMenu {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                option.action()
                                self.showFabMenu.toggle()
                            }) {
                                Image(systemName: option.icon).resizable().frame(width: 25, height: 25).padding()
                            }
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                        }
                    }
                    
                    Button(action: {
                        self.showFabMenu.toggle()
                    }) {
                        Image(systemName: "xmark").resizable().frame(width: 25, height: 25).padding()
                    }
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
                    .rotationEffect(.init(degrees: self.showFabMenu ? 0 : 135))
                }.animation(.spring())
            }
        }
    }
}
