//
//  DeliveryStrategy.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/18/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

class Delivery {
  private var strategy: DeliveryStrategy
  
  init(strategy: DeliveryStrategy) {
    self.strategy = strategy
  }
  
  func sendDelivery() {
    print(strategy.sendDelivery())
  }
}

protocol DeliveryStrategy {
  func sendDelivery() -> String
}

class DeliveryPost: DeliveryStrategy {
  func sendDelivery() -> String {
    return "Your order is sent by post"
  }
}

class DeliveryFly: DeliveryStrategy {
  func sendDelivery() -> String {
    return "Your order is sent by air"
  }
}

class DeliveryShip: DeliveryStrategy {
  func sendDelivery() -> String {
    return "Your is sent by ship"
  }
}
