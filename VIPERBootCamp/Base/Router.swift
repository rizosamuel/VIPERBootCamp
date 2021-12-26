//
//  Router.swift
//  VIPERBootCamp
//
//  Created by Rijo Samuel on 26/12/21.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter: AnyObject {
	
	var entry: EntryPoint?{ get }
	
	static func start() -> AnyRouter
}

final class UserRouter: AnyRouter {
	
	var entry: EntryPoint?
	
	static func start() -> AnyRouter {
		
		let router = UserRouter()
		let view: AnyView = UserVC()
		let presentor: AnyPresentor = UserPresentor()
		let interactor: AnyInteractor = UserInteractor()
		
		presentor.router = router
		view.presentor = presentor
		interactor.presentor = presentor
		presentor.view = view
		presentor.interactor = interactor
		router.entry = view as? EntryPoint
		return router
	}
}
