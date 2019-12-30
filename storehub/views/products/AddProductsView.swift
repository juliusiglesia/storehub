//
//  AddProductsView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI
import CoreData

struct AddProductsView: View {
    @EnvironmentObject var categoryDataManager: CategoryDataManager
    @EnvironmentObject var productDataManager: ProductDataManager
    
    @State private var name = ""
    @State private var category: ListPickerOption = .init(id: "", label: "")
    @ObservedObject private var noOfStocks = NumericValue()
    @ObservedObject private var costPrice = DecimalValue()
    @ObservedObject private var sellPrice = DecimalValue()
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Product Information")) {
                TextField("Product name", text: $name)
                ListPicker(selected: $category,  options: self.$categoryDataManager.pickerOptions, label: "Category")
                HStack {
                    TextField("Number of stocks available", text: $noOfStocks.value).keyboardType(.numberPad)
                    Spacer()
                    Text(self.noOfStocks.value.isEmpty ? "" : "stocks available").foregroundColor(Color.gray)
                }
            }
            
            Section(header: Text("Pricing Information")) {
                HStack {
                    Text("₱")
                    TextField("cost price per stock", text: $costPrice.value).keyboardType(.numberPad)
                    Spacer()
                    Text(self.costPrice.value.isEmpty ? "" : "cost per stock").foregroundColor(Color.gray)
                }
                HStack {
                    Text("₱")
                    TextField("selling price per stock", text: $sellPrice.value).keyboardType(.numberPad)
                    Spacer()
                    Text(self.sellPrice.value.isEmpty ? "" : "price per stock").foregroundColor(Color.gray)
                }
                HStack {
                    Image(systemName: "info.circle")
                    Text("XX.XX% or ₱ XX.00 is the expected earning per stock")
                }
                .foregroundColor(Color.blue)
                .font(.system(size: 12, weight: .medium))
            }
            
            Section {
                Button(action: {
                    self.productDataManager.add(name: self.name, category: self.categoryDataManager.get(id: self.category.id))
                    print(self.productDataManager.products)
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Save Product")
                    }
                    .disabled(name.isEmpty)
                }
                .disabled(name.isEmpty)
            }
        }
        .navigationBarTitle(Text("Add Product"))
        
    }
}
