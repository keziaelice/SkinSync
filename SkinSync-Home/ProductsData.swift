////
////  ProductsData.swift
////  SkinSync-Home
////
////  Created by MacBook Pro on 16/12/24.
////
//
//import Foundation
//import SwiftData
//
//@Model class ProductsData {
//    var id: String
//    var category: String
//    var brand: String
//    var skincare: String
//    var penjelasan: String
//    var skintype: String
//    var ingredients: String
//    var function: String
//    var how_to_use: String
//    var link: String
//
//    init(id: String, category: String, brand: String, skincare: String, penjelasan: String, skintype: String, ingredients: String, function: String, how_to_use: String, link: String) {
//        self.id = id
//        self.category = category
//        self.brand = brand
//        self.skincare = skincare
//        self.penjelasan = penjelasan
//        self.skintype = skintype
//        self.ingredients = ingredients
//        self.function = function
//        self.how_to_use = how_to_use
//        self.link = link
//    }
//}
//
//func cleanRows(file: String) -> String {
//    var cleanFile = file
//    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
//    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
//    cleanFile = cleanFile.replacingOccurrences(of: "\"\n", with: "")
//    cleanFile = cleanFile.replacingOccurrences(of: " ", with: "") // Menghapus spasi
//    return cleanFile
//}
//
//func loadProducts() -> [ProductsData] {
//    var listOfProducts = [ProductsData]()
//    
//    guard let filePath = Bundle.main.path(forResource: "productdata", ofType: "csv") else {
//        print("CSV file not found")
//        return []
//    }
//    print("File path: \(filePath)")
//    
//    var data = ""
//    
//    do {
//        data = try String(contentsOfFile: filePath )
//        
//        // Membersihkan data
//        data = cleanRows(file: data)
//        
//        // Memisahkan data berdasarkan newline (baris baru)
//        var rows = data.components(separatedBy: .newlines)
//        
//        // Menghapus baris kosong
//        rows = rows.filter { !$0.isEmpty }
//        
//        // Memastikan ada data
//        guard let firstRow = rows.first else {
//            print("No data found")
//            return []
//        }
//
//        let columnCount = firstRow.components(separatedBy: ",").count
//        print("Column count: \(columnCount)")  // Debugging jumlah kolom
//        
//        rows.removeFirst()  // Menghapus baris pertama (header)
//
//        // Memproses setiap baris
//        for (index, row) in rows.enumerated() {
//            let columns = row.components(separatedBy: ",")
//            
//            // Jika jumlah kolom sesuai, proses baris
//            if columns.count == columnCount {
//                print("Parsing row \(index): \(columns)")  // Debugging
//                let thisProduct = ProductsData(id: columns[0],
//                                               category: columns[1],
//                                               brand: columns[2],
//                                               skincare: columns[3],
//                                               penjelasan: columns[4],
//                                               skintype: columns[5],
//                                               ingredients: columns[6],
//                                               function: columns[7],
//                                               how_to_use: columns[8],
//                                               link: columns[9])
//                listOfProducts.append(thisProduct)
//            } else {
//                print("Row \(index) skipped: \(columns)")  // Debugging jika baris gagal diproses
//            }
//        }
//    } catch {
//        print(error)
//        return []
//    }
//    
//    return listOfProducts
//}
//
//var products = loadProducts()
