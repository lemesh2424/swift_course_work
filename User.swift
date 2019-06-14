//
//  User.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

class User {
  private var payment: Payment?
  private var deliveryType: Delivery?
  private var orders: [Order]?
  private var notification = NotificationType(Notification())
  
  func createOrder(product: Product) {
    orders = [Order]()
    orders?.append(Order())
    addToLastOrder(product: product)
  }
  
  func createOrderFromKit(kit: ([Chair], [Table], [Cabinet])) {
    orders = [Order]()
    orders?.append(Order())
    addKitToLastOrder(products: kit)
  }
  
  func addToLastOrder(product: Product) {
    let orderProduct = OrderProduct(product: product)
    orders?.last?.add(component: orderProduct)
  }
  
  func addKitToLastOrder(products: (chairs: [Chair], tables: [Table], cabinets: [Cabinet])) {
    for el in products.chairs {
      addToLastOrder(product: el)
    }
    
    for el in products.tables {
      addToLastOrder(product: el)
    }
    
    for el in products.cabinets {
      addToLastOrder(product: el)
    }
  }
  
  func setPayment(_ payment: String) {
    switch payment {
    case "Card":
      self.payment = Proxy(CardPayment())
    case "Bank":
      self.payment = Proxy(BankPayment())
    default:
      self.payment = nil
    }
  }
  
  func setDelivery(_ delivery: String) {
    print("\(delivery) delivery set")
    switch delivery {
    case "Post":
      deliveryType = Delivery(strategy: DeliveryPost())
    case "Fly":
      deliveryType = Delivery(strategy: DeliveryFly())
    case "Ship":
      deliveryType = Delivery(strategy: DeliveryShip())
    default:
      deliveryType = nil
    }
  }
  
  func setNotification(_ n: (s: String, t: String, m: String)) {
    notification = NotificationType(Notification())
    if n.s != "-" {
      notification = SmsNotification(notification)
      print("SMS set")
    }
    if n.t != "-" {
      notification = TelegramNotification(notification)
      print("Telegram set")
    }
    if n.m != "-" {
      notification = MailNotification(notification)
      print("Mail set")
    }
  }
  
  func getPrice() -> Double? {
    return orders?.last?.productPrice()
  }
  
  func closeOrder() {
    payment?.request(price: orders?.last?.productPrice() ?? 0)
    print(notification.notify())
    deliveryType?.sendDelivery()
    orders?.last?.applyOrder()
  }
  
  func checkLastOrderStatus() {
    orders?.last?.applyOrder()
  }
  
  func subscribe() -> DeliveryObserver? {
    return orders?.last?.subscribe()
  }
}
