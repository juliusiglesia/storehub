//
//  ContentView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 3
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Text("Overview")
                    .tabItem {
                        VStack {
                            Image("first")
                            Text("overview")
                        }
                    }
                    .tag(0)
                SalesListView()
                    .tabItem {
                        VStack {
                            Image("first")
                            Text("Sales")
                        }
                    }
                    .tag(1)
                Text("Inventory")
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("Inventory")
                        }
                    }
                    .tag(2)
                ProductsListView()
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("Products")
                        }
                    }
                    .tag(3)
                Text("Reports")
                    .tabItem {
                        VStack {
                            Image("first")
                            Text("Reports")
                        }
                    }
                    .tag(4)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
