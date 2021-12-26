//
//  Interactor.swift
//  VIPERBootCamp
//
//  Created by Rijo Samuel on 26/12/21.
//

import Foundation

protocol AnyInteractor: AnyObject {
	
	var presentor: AnyPresentor? { get set }
	
	func getUsers()
}

final class UserInteractor: AnyInteractor {
	
	private let url = "https://jsonplaceholder.typicode.com/users"
	var presentor: AnyPresentor?
	
	func getUsers() {
		
		guard let url = URL(string: url) else { return }
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
			guard let data = data, error == nil else {
				self.presentor?.interactorDidFetchUsers(with: .failure(error!))
				return
			}
			
			do {
				let entities = try JSONDecoder().decode([User].self, from: data)
				self.presentor?.interactorDidFetchUsers(with: .success(entities))
			} catch {
				self.presentor?.interactorDidFetchUsers(with: .failure(error))
				print(error.localizedDescription)
			}
		}
		
		task.resume()
	}
}
