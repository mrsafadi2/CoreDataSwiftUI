//
//  CoreDataViewModel.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import Foundation
import CoreData

class CoreDataViewModel:ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var categories:[Category] = []{
        didSet{
            manager.save()
        }
    }
    
    @Published var products:[Product] = []{
        didSet{
            manager.save()
        }
    }
    

}

extension CoreDataViewModel:CategoryCD{
    //MARK:  this extention go split category logic from product logic
    
    func addtoCategory( _ categroy:CategoryAPI){
        let newCategory = Category(context: manager.context)
        newCategory.id = Int16(categroy.id)
        newCategory.name = categroy.name

        manager.save()
        getGategories()
    }
    
    func getGategories(){
        let request = NSFetchRequest<Category>(entityName: "Category")
        do {
            self.categories =  try  manager.context.fetch(request)
        }
        catch(let error){
            fatalError("Error :\(error.localizedDescription)")
        }
    }
    
    func deleteCatgeory(_ category:Category){
        manager.delete(category)
        getGategories()
    }
}

extension CoreDataViewModel:ProductCD{
    //MARK:  this extention go split product logic from category logic

    func addtoProduct(_ product:ProductAPI) { 
        let newProduct = Product(context: manager.context)
        newProduct.id = Int16(product.id)
        newProduct.name = product.name
        newProduct.toCategory = product.category
        
        manager.save()
        getProducts(nil)
    }
    
    func getProducts(_ filter:String?) {
        let request = NSFetchRequest<Product>(entityName: "Product")
        let sort  = NSSortDescriptor(keyPath: \Product.name, ascending: true)
        let predicate = NSPredicate(format: "name = %@", filter ?? "")
        request.sortDescriptors = [sort]
        if filter != nil {
            request.predicate = predicate
        }
        do {
            self.products =  try  manager.context.fetch(request)
        }
        catch(let error){
            fatalError("Error :\(error.localizedDescription)")
        }

    }
    
    func updateProduct(entity:Product, newValue:String){
        let request = NSFetchRequest<Product>(entityName: "Product")
        let predicate = NSPredicate(format: "id == %i", entity.id as Int16)
        request.predicate = predicate
        let results = try? manager.context.fetch(request)
        if (results?.first) != nil {
            entity.name = newValue
            manager.save()
        }
    }
    
    func deleteProduct(_ product:Product){
        manager.delete(product)
        getProducts(nil)
    }
    
    
}
