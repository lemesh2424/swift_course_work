//
//  Payment.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

protocol Payment {
  func request(price: Double)
}

class CardPayment: Payment {
  func request(price: Double) {
    print("Payment from your card applied. You spent \(price)$")
  }
}

class BankPayment: Payment {
  func request(price: Double) {
    print("Payment applied by PayPal. You spent \(price)$")
  }
}

class Proxy: Payment {
  private var paymentType: Payment
  
  init(_ paymentType: Payment) {
    self.paymentType = paymentType
  }
  
  func request(price: Double) {
    if checkPayment() {
      paymentType.request(price: price)
    }
  }
  
  private func checkPayment() -> Bool {
    print("You have money on your card/bank account")
    return true
  }
}
