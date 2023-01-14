//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Product.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: false)])
    var products:FetchedResults<Product>
    
   //MARK: You can do the fetch request direclty in view  , useing FetchRequest property Wrapper and assign the result to variable in view
    
   // @FetchRequest(entity: Category.entity(),
   //             sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: false)])
   // var categories:FetchedResults<Category>
    
    @StateObject var CRVM:CoreDataViewModel = CoreDataViewModel()
    @State var isCategorySelected:Bool = true
    @State var isProductsSelected:Bool = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            CRVM.addtoCategory(CategoryAPI(id: 1, name: "أبشر الأفراد"))
                            isCategorySelected = true
                            isProductsSelected = false

                        }
                    } label: {
                         Text("Add Category ")
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.cornerRadius(20))
                    }
                    Button {
                        withAnimation {
                            CRVM.addtoProduct(ProductAPI(id: 1, name: "اصدار جوازات ", category: CRVM.categories.first!))
                            isProductsSelected = true
                            isCategorySelected = false

                        }
                    } label: {
                         Text("Add Product ")
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.cornerRadius(20))
                    }
                }
                ZStack{
                    if isCategorySelected {
                        withAnimation {
                            List(CRVM.categories) { item in
                                Text("\(item.name ?? "" )")
                                    .onTapGesture {
                                        CRVM.deleteCatgeory(item)
                                    }
                            }.task {
                                CRVM.getGategories()
                            }

                        }
                    }
                    if isProductsSelected {
                        withAnimation {
                            List(CRVM.products) { item in
                                HStack {
                                    Text("\(item.name ?? "" )")
                                    Text("\(item.toCategory?.name ?? "")")
                                    Button("Update"){
                                       // CRVM.updateProduct(entity: item, newValue: "إصدار تراخيص")
                                      //  CRVM.getProducts(nil)
                                    }
                                }.onTapGesture {
                                   // CRVM.deleteProduct(item)
                                    CRVM.updateProduct(entity: item, newValue: "إصدار  هويات ")
                                    CRVM.getProducts(nil)

                                    isProductsSelected = true
                                    isCategorySelected = false
                                }
                                
                            }.task {
                                CRVM.getProducts(nil)
                            }
                             
                        }
                    }
                }

            }
            .padding()
            .navigationTitle("Core Data Example")
        }
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
