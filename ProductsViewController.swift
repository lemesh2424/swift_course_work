//
//  ProductsViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 5/10/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, AddItemViewControllerDelegate {
  func itemDetailViewControllerDidCancel(_ controller: AddProductViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBOutlet weak var tableView: UITableView!
  let shop = Shop.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
  }
  
  func itemDetailViewController(_ controller: AddProductViewController, didFinishAdding item: Product) {
    let newRowIndex = shop.products.count
    shop.products.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    navigationController?.popViewController(animated: true)
    saveChecklistItems()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
      let controller = segue.destination as! AddProductViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! AddProductViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = shop.products[indexPath.row]
      }
    }
  }
  
  func itemDetailViewController(_ controller: AddProductViewController, didFinishEditing item: Product) {
    if let index = shop.products.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel?.text = shop.products[indexPath.row].name
      }
    }
    
    navigationController?.popViewController(animated: true)
    saveChecklistItems()
  }
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func saveChecklistItems() {
    let encoder = PropertyListEncoder()
    
    do {
      let data = try encoder.encode(shop.products)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding item array: \(error.localizedDescription)")
    }
  }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(shop.products[indexPath.row].name) - \(shop.products[indexPath.row].price)$"
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shop.products.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let vc = storyboard?.instantiateViewController(withIdentifier: "addproduct") as? AddProductViewController {
      vc.delegate = self
      vc.itemToEdit = shop.products[indexPath.row]
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}
