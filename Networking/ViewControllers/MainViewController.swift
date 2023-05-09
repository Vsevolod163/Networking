//
//  MainViewController.swift
//  Networking
//
//  Created by Vsevolod Lashin on 05.05.2023.
//

import UIKit


enum UserAction: CaseIterable {
    case showImage
    case fetchCourse
    case fetchCourses
    case aboutSwiftBook
    case aboutSwiftBook2
    case showCourses
    
    var title: String {
        switch self {
        case .showImage:
            return "Show Image"
        case .fetchCourse:
            return "Fetch Course"
        case .fetchCourses:
            return "Fetch Courses"
        case .aboutSwiftBook:
            return "About SwiftBook"
        case .aboutSwiftBook2:
            return "About SwiftBook 2"
        case .showCourses:
            return "Show Courses"
        }
    }
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UICollectionViewController {

    private let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].title
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .fetchCourse: fetchCourse()
        case .fetchCourses: fetchCourses()
        case .aboutSwiftBook: fetchInfoAbout()
        case .aboutSwiftBook2: fetchInfoAboutUsWithEmptyFields()
        case .showCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        }
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }

     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showCourses" {
             guard let coursesVC = segue.destination as? CoursesViewController else { return }
             coursesVC.fetchCourses()
         }
     }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCourse() {
        URLSession.shared.dataTask(with: Link.courseURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let course = try decoder.decode(Course.self, from: data)
                print(course)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }.resume()
    }
    
    private func fetchCourses() {
        URLSession.shared.dataTask(with: Link.coursesURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let courses = try decoder.decode([Course].self, from: data)
                print(courses)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }.resume()
    }
    
    private func fetchInfoAbout() {
        URLSession.shared.dataTask(with: Link.aboutUsURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let sbInfo = try decoder.decode(SwiftBookInfo.self, from: data)
                print(sbInfo)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }.resume()
    }
    
    private func fetchInfoAboutUsWithEmptyFields() {
        URLSession.shared.dataTask(with: Link.aboutUsURL2.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let sbInfo = try decoder.decode(SwiftBookInfo.self, from: data)
                print(sbInfo)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }.resume()
    }
}
