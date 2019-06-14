//
//  ViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 4/19/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    loadChecklistItems()
  }
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func loadChecklistItems() {
    let path = dataFilePath()
    
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        Shop.shared.products = try decoder.decode([Product].self, from: data)
      } catch {
        print("Error decoding item array: \(error.localizedDescription)")
      }
    }
  }
}
