//
//  ProductsView.swift
//  storehub
//
//  Created by Julius Iglesia on 28/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject var categoryDataManager: CategoryDataManager
    @EnvironmentObject var productDataManager: ProductDataManager
    
    @State private var showAddProductsView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(self.productDataManager.products, id: \.self) { product in
                        NavigationLink (destination: Text(product.wrappedName)) {
                            VStack(alignment: .leading) {
                                Text(product.wrappedName)
                                Text("99 stocks available").foregroundColor(Color.gray)
                                Text("₱ 99.50 per stock").foregroundColor(Color.gray)
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
                        .environmentObject(self.categoryDataManager)
                        .environmentObject(self.productDataManager)
                }
            }
        }
    }
    
    func open() {
        self.showAddProductsView.toggle()
    }
}
