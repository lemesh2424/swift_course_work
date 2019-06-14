//
//  FurnitureFactory.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

protocol AbstractFurnitureFactory {
  func createChair() -> Chair
  func createTable() -> Table
  func createCabinet() -> Cabinet
  func createKit(chair: Int, table: Int, cabinet: Int) -> ([Chair], [Table], [Cabinet])
}

protocol Chair: Product {
  func create() -> String
}

class ModernChair: Product, Chair {
  func create() -> String {
    return "Modern chair created"
  }
}

class WoodenChair: Product, Chair {
  func create() -> String {
    return "Wooden chair created"
  }
}

protocol Table: Product {
  func create() -> String
}

class ModernTable: Product, Table {
  func create() -> String {
    return "Modern table created"
  }
}

class WoodenTable: Product, Table {
  func create() -> String {
    return "Wooden table created"
  }
}

protocol Cabinet: Product {
  func create() -> String
}

class ModernCabinet: Product, Cabinet {
  func create() -> String {
    return "Modern cabinet created"
  }
}

class WoodenCabinet: Product, Cabinet {
  func create() -> String {
    return "Wooden cabinet created"
  }
}

class WoodenFactory: AbstractFurnitureFactory {
  func createChair() -> Chair {
    return WoodenChair(name: "Wooden Chair", price: 15, category: "Furniture")
  }
  func createTable() -> Table {
    return WoodenTable(name: "Wooden Table", price: 20, category: "Furniture")
  }
  func createCabinet() -> Cabinet {
    return WoodenCabinet(name: "Wooden Cabinet", price: 30, category: "Furniture")
  }
  func createKit(chair: Int, table: Int, cabinet: Int) -> ([Chair], [Table], [Cabinet]) {
    assert(chair >= 0 || table >= 0 || cabinet >= 0, "You can't order less than 0 element")
    var chairs = [Chair]()
    var tables = [Table]()
    var cabinets = [Cabinet]()
    if chair > 0 {
      chairs.append(createChair())
      for _ in 1..<chair {
        chairs.append(chairs.first?.copy() as? Product as! Chair)
      }
    }
    if table > 0 {
      tables.append(createTable())
      for _ in 1..<table {
        tables.append(tables.first?.copy() as? Product as! Table)
      }
    }
    if cabinet > 0 {
      cabinets.append(createCabinet())
      for _ in 1..<cabinet {
        cabinets.append(cabinets.first?.copy() as? Product as! Cabinet)
      }
    }
    return (chairs, tables, cabinets)
  }
}

class ModernFactory: AbstractFurnitureFactory {
  func createChair() -> Chair {
    return ModernChair(name: "Modern Chair", price: 30, category: "Furniture")
  }
  func createTable() -> Table {
    return ModernTable(name: "Modern Table", price: 50, category: "Furniture")
  }
  func createCabinet() -> Cabinet {
    return ModernCabinet(name: "Modern Cabinet", price: 70, category: "Furniture")
  }
  func createKit(chair: Int, table: Int, cabinet: Int) -> ([Chair], [Table], [Cabinet]) {
    assert(chair < 0 || table < 0 || cabinet < 0, "You can't order less than 0 element")
    var chairs = [Chair]()
    var tables = [Table]()
    var cabinets = [Cabinet]()
    if chair > 0 {
      chairs.append(createChair())
      for _ in 1..<chair {
        chairs.append(chairs.first?.copy() as? Product as! Chair)
      }
    }
    if table > 0 {
      tables.append(createTable())
      for _ in 1..<table {
        tables.append(tables.first?.copy() as? Product as! Table)
      }
    }
    if cabinet > 0 {
      cabinets.append(createCabinet())
      for _ in 1..<cabinet {
        cabinets.append(cabinets.first?.copy() as? Product as! Cabinet)
      }
    }
    return (chairs, tables, cabinets)
  }
}
