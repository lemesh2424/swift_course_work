//
//  FurnitureViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 5/11/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

class FurnitureViewController: UIViewController {

  @IBOutlet weak var modernTable: UITableView!
  @IBOutlet weak var woodenTable: UITableView!
  
  let modernFactory = ModernFactory()
  let woodenFactory = WoodenFactory()
  
  var modern: [Product]?
  var wooden: [Product]?
  
  @IBOutlet weak var ordersCount: UILabel!
  @IBOutlet weak var orderPrice: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    modernTable.delegate = self
    modernTable.dataSource = self
    modernTable.register(UITableViewCell.self, forCellReuseIdentifier: "modern")
    view.addSubview(modernTable)
    
    modern = [modernFactory.createChair(), modernFactory.createTable(), modernFactory.createCabinet()]
    
    woodenTable.delegate = self
    woodenTable.dataSource = self
    woodenTable.register(UITableViewCell.self, forCellReuseIdentifier: "wooden")
    view.addSubview(woodenTable)
    wooden = [woodenFactory.createChair(), woodenFactory.createTable(), woodenFactory.createCabinet()]
    ordersCount.text = "\(productsInOrder)"
    if let sum = user.getPrice() {
      orderPrice.text = "\(sum)$"
    }
  }
}

extension FurnitureViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == modernTable {
      let cell = tableView.dequeueReusableCell(withIdentifier: "modern", for: indexPath)
      if let item = modern?[indexPath.row] {
        cell.textLabel?.text = "\(item.name) - \(item.price)$"
      } else {
        cell.textLabel?.text = "-"
      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "wooden", for: indexPath)
      if let item = wooden?[indexPath.row] {
        cell.textLabel?.text = "\(item.name) - \(item.price)$"
      } else {
        cell.textLabel?.text = "-"
      }
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if tableView == modernTable {
      if productsInOrder == 0, let item = modern?[indexPath.row] {
        user.createOrder(product: item)
        if let sum = user.getPrice() {
          orderPrice.text = "\(sum)$"
        }
        productsInOrder += 1
        ordersCount.text = "\(productsInOrder)"
      } else if let item = modern?[indexPath.row] {
        user.addToLastOrder(product: item)
        if let sum = user.getPrice() {
          orderPrice.text = "\(sum)$"
        }
        productsInOrder += 1
        ordersCount.text = "\(productsInOrder)"
      }
    } else if tableView == woodenTable {
      if productsInOrder == 0, let item = wooden?[indexPath.row] {
        user.createOrder(product: item)
        if let sum = user.getPrice() {
          orderPrice.text = "\(sum)$"
        }
        productsInOrder += 1
        ordersCount.text = "\(productsInOrder)"
      } else if let item = wooden?[indexPath.row] {
        user.addToLastOrder(product: item)
        if let sum = user.getPrice() {
          orderPrice.text = "\(sum)$"
        }
        productsInOrder += 1
        ordersCount.text = "\(productsInOrder)"
      }
    }
  }
}
