//
//  Presentor.swift
//  VIPERBootCamp
//
//  Created by Rijo Samuel on 26/12/21.
//

import Foundation

protocol AnyPresentor: AnyObject {
	
	var router: AnyRouter? { get set }
	var interactor: AnyInteractor? { get set }
	var view: AnyView? { get set }
	
	func interactorDidFetchUsers(with result: Result<[User], Error>)
}

final class UserPresentor: AnyPresentor {
	
	var router: AnyRouter?
	
	var interactor: AnyInteractor? {
		didSet {
			interactor?.getUsers()
		}
	}
	
	var view: AnyView?
	
	func interactorDidFetchUsers(with result: Result<[User], Error>) {

		switch result {
				
			case .success(let users):
				view?.update(with: users)
				
			case .failure(let error):
				view?.update(with: error)
		}
	}
}
