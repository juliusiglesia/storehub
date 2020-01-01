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
    @EnvironmentObject var storeHubData: StoreHubDataManager
    
    @State private var name = ""
    @State private var category: ListPickerOption = .init(id: "", label: "")
    @ObservedObject private var noOfStocks = NumericValue()
    @ObservedObject private var costPrice = DecimalValue()
    @ObservedObject private var sellPrice = DecimalValue()
    
    // Derived values
    private var isFormValid: Bool {
        ![ self.name, self.category.id, self.noOfStocks.value, self.costPrice.value, self.sellPrice.value ].isAnyEmpty
    }
    
    private var profitOrLossAmt: Double { sellPrice.number - costPrice.number }
    
    private var profitOrLossPct: Double { 100 * (sellPrice.number - costPrice.number) / costPrice.number }
    
    private var profitOrLossText: String {
        if costPrice.value.isEmpty || sellPrice.value.isEmpty {
            return "Enter cost and selling price to see potential earnings."
        }
        
        if profitOrLossAmt > 0 {
            return "Your expected earning is +₱\(profitOrLossAmt.money) (+\(profitOrLossPct.string)%) per stock."
        }
        
        if profitOrLossAmt < 0 {
            return "Your expected earning is -₱\(abs(profitOrLossAmt).money) (-\(abs(profitOrLossPct).string)%) per stock."
        }
        
        return "You are just break-even for this product."
    }
    
    private var profitOrLossTextColor: Color {
        if costPrice.value.isEmpty || sellPrice.value.isEmpty {
            return Color.yellow
        }
        
        if profitOrLossAmt > 0 {
            return Color.green
        }
        
        if profitOrLossAmt < 0 {
            return Color.red
        }
        
        return Color.blue
    }
    
    var body: some View {
        Form {
            Section(header: Text("Product Information")) {
                TextField("Product name", text: $name)
                ListPicker(selected: $category,  options: self.$storeHubData.managers.category.pickerOptions, label: "Category")
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
                    Text(profitOrLossText)
                }
                .foregroundColor(profitOrLossTextColor)
                .font(.system(size: 12, weight: .medium))
            }
            
            Section {
                Button(action: {
                    self.storeHubData.addProduct(
                        name: self.name,
                        category: self.storeHubData.managers.category.get(id: self.category.id),
                        noOfStocks: self.noOfStocks.number,
                        costPrice: self.costPrice.number,
                        sellPrice: self.sellPrice.number
                    )
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Save Product")
                    }
                    .disabled(!isFormValid)
                }
                .disabled(!isFormValid)
            }
        }
        .navigationBarTitle(Text("Add Product"))
        
    }
}
