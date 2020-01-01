//
//  SalesListView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct SalesListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink (destination: AddSalesView()) {
                    Text("1")
                }
                NavigationLink (destination: AddSalesView()) {
                    Text("2")
                }
                NavigationLink (destination: AddSalesView()) {
                    Text("3")
                }
            }
            .navigationBarTitle(Text("Sales"))
        }
        .padding()
    }
}

struct SalesListView_Previews: PreviewProvider {
    static var previews: some View {
        SalesListView()
    }
}
