//
//  ViewController.swift
//  CoreData-App
//
//  Created by Bahittin on 15.09.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let context = appDelegate.persistentContainer.viewContext
    var kisilerArray = [Kisiler]()
    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()
        readData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func saveData() {
        let kisi = Kisiler(context: context)
        kisi.kisi_ad = "bahittin"
        kisi.kisi_yas = 18
        
        appDelegate.saveContext()
    }
    
    func readData() {
        do {
            kisilerArray = try context.fetch(Kisiler.fetchRequest())
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
        
        for arr in kisilerArray {
            print("Ad: \(arr.kisi_ad!) | Yaş: \(arr.kisi_yas)")
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        kisilerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = kisilerArray[indexPath.row].kisi_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deleteData = kisilerArray[indexPath.row]
        self.context.delete(deleteData)
        appDelegate.saveContext()
        DispatchQueue.main.async {
            self.readData()
            tableView.reloadData()
        }
    }
    
}

