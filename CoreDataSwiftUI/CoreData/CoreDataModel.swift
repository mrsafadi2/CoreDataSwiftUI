//
//  CoreDataModel.swift
//  CoreDataSwiftUI
//
//  Created by Mohammed Safadi Macbook Pro on 14/01/2023.
//

import Foundation

struct CategoryAPI {
    let id:Int
    let name:String
}

struct ProductAPI {
    let id:Int
    let name:String
    let category:Category
}

protocol CategoryCD {
    func addtoCategory(_ categroy:CategoryAPI)
    func getGategories()
}

protocol ProductCD{
    func addtoProduct(_ product:ProductAPI)
    func getProducts(_ filter:String?)
}
