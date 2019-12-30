//
//  ListPicker.swift
//  storehub
//
//  Created by Julius Iglesia on 29/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI
import CoreData

struct ListPickerOption: Hashable, Identifiable {
    var id: String
    var label: String
    
    init(id: String, label: String) {
        self.id = id
        self.label = label
    }
    
    static func == (lhs: ListPickerOption, rhs: ListPickerOption) -> Bool {
        return lhs.id == rhs.id && lhs.label == rhs.label
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(label)
    }
}

struct ListPickerChooser: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selected: ListPickerOption
    @Binding var options: Array<ListPickerOption>
    
    var label: String
    
    var body: some View {
        Form {
            Section (header: Text("Select or add a new one if not available")) {
                ForEach(self.options, id: \.self) { option in
                    HStack {
                        Button(action: {
                            self.selected = option
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(option.label)
                        }
                        .foregroundColor(Color.black)
                        Spacer()
                        if self.selected == option {
                            Image(systemName: "checkmark").foregroundColor(Color.blue)
                        }
                    }
                }
            }
            
            Section {
                NavigationLink(destination: AddCategoryView()) {
                    Image(systemName: "plus.circle.fill")
                    Text("Add \(label)".capitalized)
                }.foregroundColor(Color.blue)
            }
        }
        .navigationBarTitle("Select \(label)".capitalized)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListPicker: View {
    @Binding var selected: ListPickerOption
    @Binding var options: Array<ListPickerOption>
    
    var label: String
    
    var body: some View {
        NavigationLink(destination: ListPickerChooser(selected: $selected, options: $options, label: label)) {
            HStack{
                Text(label)
                Spacer()
                Text("\(selected.label)").foregroundColor(Color.gray)
            }
        }
    }
}
