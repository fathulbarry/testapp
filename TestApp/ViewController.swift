//
//  ViewController.swift
//  TestApp
//
//  Created by Prijo on 4/5/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var database = DatabaseHelper()
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try database.viewContext.execute(NSBatchDeleteRequest(fetchRequest: User.fetchRequest() as NSFetchRequest<NSFetchRequestResult>))
        } catch {
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.L
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 70
//
//        database.container.loadPersistentStores { [weak self] (storeDesc, error) in
//            self?.database.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//            if let error = error {
//                print("Error \(error)")
//            }
//        }

        getUsers { [weak self] (ok) in
            guard let self = self else { return }
            if (ok) {
                self.users = self.database.load()
            }
            self.tableView.reloadData()
        }
        
    }
    
    func getUsers(_ since: Int = 0, _ completion: @escaping (Bool) -> ()) {
        let url = URL(string: "https://api.github.com/users?since=\(since)")

        // API Request
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                // Decode the result using Codable, save the database
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = self.database.viewContext
                let _ = try decoder.decode([User].self, from: data)
                self.database.commit()

                // Return to main thread
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let err {
                print("Error", err)
                completion(false)
            }
        }.resume()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell") as! NormalTableViewCell
        
        cell.usernameLbl.text = users[indexPath.row].login
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.user = users[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    
}

