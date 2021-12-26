//
//  View.swift
//  VIPERBootCamp
//
//  Created by Rijo Samuel on 26/12/21.
//

import UIKit

protocol AnyView {
	
	var presentor: AnyPresentor? { get set }
	
	func update(with users: [User])
	func update(with error: Error)
}

class UserVC: UIViewController, AnyView {
	
	private let tableView: UITableView = {
		
		let tableView = UITableView()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.isHidden = true
		return tableView
	}()
	
	private var users: [User] = []
	
	var presentor: AnyPresentor?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.backgroundColor = .systemOrange
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}
	
	func update(with users: [User]) {
		DispatchQueue.main.async {
			self.users = users
			self.tableView.reloadData()
			self.tableView.isHidden = false
		}
	}
	
	func update(with error: Error) {
		
	}
}

// MARK: - Table View Delegate Methods
extension UserVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = users[indexPath.row].name
		return cell
	}
}
