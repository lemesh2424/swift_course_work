//
//  Product.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

class BaseProduct: NSCopying, Equatable, Codable {
  var name: String
  var price: Double
  var category: String
  
  required init(name: String = "Name", price: Double = 0.0, category: String = "Category") {
    self.name = name
    self.price = price
    self.category = category
  }
  
  func copy(with zone: NSZone? = nil) -> Any {
    let prototype = type(of: self).init()
    prototype.name = name
    prototype.price = price
    prototype.category = category
    print("Values defined in BaseProduct have been cloned!")
    return prototype
  }
  
  static func == (lhs: BaseProduct, rhs: BaseProduct) -> Bool {
    return lhs.name == rhs.name && lhs.price == rhs.price && lhs.category == rhs.category
  }
}

class Product: BaseProduct {
  override func copy(with zone: NSZone? = nil) -> Any {
    guard let prototype = super.copy(with: zone) as? Product else {
      return Product()
    }
    return prototype
  }
}
