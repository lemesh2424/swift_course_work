//
//  OrderState.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/18/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

class Context {
  private var state: State
  
  init(_ state: State) {
    self.state = state
    transitionTo(state: state)
  }
  
  func transitionTo(state: State) {
    self.state = state
    self.state.update(context: self)
  }
  
  func request() {
    state.handle()
  }
}

protocol State: class {
  func update(context: Context)
  
  func handle()
}

class BaseState: State {
  private (set) weak var context: Context?
  
  func update(context: Context) {
    self.context = context
  }
  
  func handle() {}
}

class Moderate : BaseState {
  override func handle() {
    print("Your order waiting for applying")
    context?.transitionTo(state: Applied())
  }
}

class Applied: BaseState {
  override func handle() {
    print("Your order applied and preparing for shipment")
    context?.transitionTo(state: Sent())
  }
}

class Sent: BaseState {
  override func handle() {
    print("Your order is sent")
  }
}
