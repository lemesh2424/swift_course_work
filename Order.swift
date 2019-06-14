//
//  Order.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

protocol Component {
  var parent: Component? { get set }
  
  func add(component: Component)
  
  func isComposite() -> Bool
  func productPrice() -> Double
}

extension Component {
  func add(component: Component) {}
  func isComposite() -> Bool {
    return false
  }
}

class OrderProduct: Component {
  var parent: Component?
  var product: Product
  
  init(product: Product) {
    self.product = product
  }
  
  func productPrice() -> Double {
    return product.price
  }
}

class Order: Component {
  var parent: Component?
  
  private var children = [Component]()
  
  var state = Context(Moderate())
  var subcription = Subscriber()
  
  func add(component: Component) {
    var item = component
    item.parent = self
    children.append(item)
  }
  
  func isComposite() -> Bool {
    return true
  }
  
  func productPrice() -> Double {
    return children.reduce (0, { $0 + $1.productPrice()  })
  }
  
  func applyOrder() {
    state.request()
  }
  
  func subscribe() -> DeliveryObserver {
    return subcription
  }
}
