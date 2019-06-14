//
//  Notification.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import Foundation

protocol INotification {
  func notify() -> String
}

class Notification: INotification {
  func notify() -> String {
    return "You will receive your notifications on your phone"
  }
}

class NotificationType: INotification {
  private var notification: INotification
  
  init(_ notification: INotification) {
    self.notification = notification
  }
  
  func notify() -> String {
    return notification.notify()
  }
}

class MailNotification: NotificationType {
  override func notify() -> String {
    return super.notify() + ", on your mail"
  }
}

class SmsNotification: NotificationType {
  override func notify() -> String {
    return super.notify() + ", on your phone number"
  }
}

class TelegramNotification: NotificationType {
  override func notify() -> String {
    return super.notify() + ", in your Telegram"
  }
}
