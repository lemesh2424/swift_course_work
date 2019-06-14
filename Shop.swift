//
//  Shop.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

class Shop {
  var products = [Product]()
  var orders = [Order]()
  
  static var shared: Shop = {
    let instance = Shop()
    return instance
  }()
  
  private init() {}
}

extension Shop: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    return self
  }
}
