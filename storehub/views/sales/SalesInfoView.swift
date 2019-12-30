//
//  SalesInfoView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct SalesInfoView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Name's placeholder", text: $name).padding()
        }
    }
}

struct SalesInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SalesInfoView()
    }
}
