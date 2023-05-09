//
//  CoursesViewController.swift
//  Networking
//
//  Created by Vsevolod Lashin on 05.05.2023.
//

import UIKit

final class CoursesViewController: UITableViewController {

    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        
        
        
        return cell
    }
}

// MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
        URLSession.shared.dataTask(with: Link.coursesURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self?.courses = try decoder.decode([Course].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
