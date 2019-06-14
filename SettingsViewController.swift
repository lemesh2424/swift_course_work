//
//  SettingsViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 5/11/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var picker: UIPickerView!
  @IBOutlet weak var pickerView: UIPickerView!
  
  var pickerData: [String] = [String]()
  var pickerData2 = [[String]]()
  var sms = "-"
  var tel = "-"
  var mail = "-"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.picker.delegate = self
    self.picker.dataSource = self
    
    self.pickerView.delegate = self
    self.pickerView.dataSource = self

    pickerData = ["Plane", "Ship", "Post"]
    pickerData2 = [["-", "SMS"],["-", "Telegram"], ["-", "Mail"]]
}
    

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    if pickerView == self.pickerView {
      return 3
    } else {
      return 1
    }
  }
  
  // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 1 {
      return pickerData2.count - 1
    } else {
      return pickerData.count
    }
  }
  
  // The data to return fopr the row and component (column) that's being passed in
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == self.pickerView {
      return pickerData2[component][row]
    } else {
      return pickerData[row]
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView != self.pickerView {
      user.setDelivery(pickerData[row])
    } else {
      if component == 0 {
        sms = pickerData2[0][row]
      } else if component == 1 {
        tel = pickerData2[1][row]
      } else if component == 2 {
        mail = pickerData2[2][row]
      }
      
      user.setNotification((s: sms, t: tel, m: mail))
    }
  }
}
