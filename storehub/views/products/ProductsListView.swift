//
//  ProductsListView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject var storeHubData: StoreHubDataManager
    
    @State private var showAddProductsView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(self.storeHubData.productCatalog, id: \.self) { productCatalog in
                        NavigationLink (destination: Text(productCatalog.product.wrappedName)) {
                            VStack(alignment: .leading) {
                                Text(productCatalog.product.wrappedName)
                                Text("99 stocks available").foregroundColor(Color.gray)
                                Text("₱\(productCatalog.price?.sell.decimalString ?? "??") per stock").foregroundColor(Color.gray)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Products"))
            }
            .padding()
            
            FloatingButton(
                options: [
                    FloatingButtonOptions(id: "1", icon: "bag.fill", action: open),
                    FloatingButtonOptions(id: "2", icon: "cart.fill", action: open)
                ]
            ).padding(20)
            .sheet(isPresented: $showAddProductsView){
                Modal {
                    AddProductsView()
                        .environmentObject(self.storeHubData)
                }
            }
        }
    }
    
    func open() {
        self.showAddProductsView.toggle()
    }
}
