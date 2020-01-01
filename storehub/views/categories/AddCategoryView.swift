//
//  AddCategoryView.swift
//  storehub
//
//  Created by Julius Iglesia on 29/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI
import CoreData

struct AddCategoryView: View {
    @EnvironmentObject var storeHubData: StoreHubDataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name = ""
    
    var body: some View {
        Form {
            Section (header: Text("Category Information")) {
                TextField("Name", text: $name)
            }
            
            Section {
                Button(action: {
                    self.storeHubData.managers.category.add(label: self.name)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Save Category")
                    }
                    .disabled(name.isEmpty)
                }
                .disabled(name.isEmpty)
            }
        }
        .navigationBarTitle("Add Category")
    }
}
