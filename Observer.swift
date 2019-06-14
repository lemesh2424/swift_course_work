//
//  Observer.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/18/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

protocol DeliveryObserver: class {
  func statusChanged(status: String, newStatus: String)
}

protocol DeliverySubject: class {
  func addObserver(observer: DeliveryObserver)
  func removeObserver(observer: DeliveryObserver)
  func notifyObject()
}

class Status: DeliverySubject {
  private var status: String?
  private var newStatus: String?
  
  var observerCollection = [DeliveryObserver]()
  
  func addObserver(observer: DeliveryObserver) {
    self.observerCollection.append(observer)
  }
  
  func removeObserver(observer: DeliveryObserver) {
    if let index = self.observerCollection.firstIndex(where: { $0 === observer }) {
      self.observerCollection.remove(at: index)
    }
  }
  
  func notifyObject() {
    for observer in observerCollection {
      observer.statusChanged(status: self.status!, newStatus: self.newStatus!)
    }
  }
  
  func changeStatus(status: String, newStatus: String) {
    self.newStatus = newStatus
    self.status = status
    notifyObject()
  }
}

class Subscriber: DeliveryObserver {
  func statusChanged(status: String, newStatus: String) {
    print("Your delivery status changed from \(status) to \(newStatus)")
  }
}
