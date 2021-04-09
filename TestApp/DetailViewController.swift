//
//  DetailViewController.swift
//  TestApp
//
//  Created by Prijo on 4/8/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var detailTxt: UITextView!
    @IBOutlet weak var notesTxt: UITextView!
    @IBAction func saveBtn(_ sender: Any) {
        user.notes = notesTxt.text
        database.commit()
    }
    
    var user: User!
    let database = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()

        loadProfile(user.id) { [weak self] in
            guard let self = self else { return }
            self.detailTxt.text = """
            Name = \(self.user.name ?? "")
            Email = \(self.user.email ?? "")
            Blog = \(self.user.blog ?? "")
            Company = \(self.user.company ?? "")
            """
            self.notesTxt.text = self.user.notes
        }
    }
    
    func setupComponents() {
        profileImg.layer.borderWidth = 1
        profileImg.layer.borderColor = UIColor.gray.cgColor
        detailTxt.layer.borderWidth = 1
        detailTxt.layer.borderColor = UIColor.gray.cgColor
        notesTxt.layer.borderWidth = 1
        notesTxt.layer.borderColor = UIColor.gray.cgColor
    }
    
    func loadProfile(_ id: Int16, _ completion: @escaping () -> ()) {
        let url = URL(string: "https://api.github.com/user/\(id)")
        
        // API Request
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            guard let data = data, let self = self else { return }
            do {
                // Decode the result using Codable, save the database
                let decoder = JSONDecoder()
                let detail = try decoder.decode(Detail.self, from: data)
                
                print(detail)
                
                self.user.name = detail.name
                self.user.email = detail.email
                self.user.blog = detail.blog
                self.user.company = detail.company
                self.user.location = detail.location
                self.user.followers = detail.followers
                self.user.following = detail.following
                
                self.database.commit()
                
                // Return to main thread
                DispatchQueue.main.async {
                    completion()
                }
            } catch let err {
                print("Error", err)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
