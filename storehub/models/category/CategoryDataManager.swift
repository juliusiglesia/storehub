//
//  CategoryDataManager.swift
//  storehub
//
//  Created by Julius Iglesia on 29/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class CategoryDataManager: ObservableObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var data: Array<Category> = []
    @Published var pickerOptions: Array<ListPickerOption> = []
    
    init() {
        refresh()
    }
    
    func refresh() {
        do {
            self.data = try context.fetch(Category.getAllCategoriesRequest())
            self.pickerOptions = data.map { .init(id: $0.wrappedId, label: $0.wrappedLabel) }
        } catch {
            print("Error fetching categories, \(error)")
        }
    }
    
    func save(label: String) {
        let category = Category(context: context)
        category.label = label
        category.setCreateTimestamp()
        
        do {
            try context.save()
            refresh()
        } catch {
            print("Error saving category, \(category)")
        }
    }
    
    func get(id: String) -> Category? {
        return self.data.filter {
            $0.wrappedId == id
        }.first
    }
}
