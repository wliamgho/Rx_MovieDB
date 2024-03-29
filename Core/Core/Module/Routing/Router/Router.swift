//
//  Router.swift
//  MovieDB
//
//  Created by William on 23/12/21.
//

import Foundation
import RxSwift

/// Use to set which screen will shown
public protocol Route {}

/// Abstract as the navigator of a Coordinator.
public protocol Routable: AnyObject {
    associatedtype ScreenRoute: Route
    func navigateTo(route: ScreenRoute, animated: Bool)
}

public final class Router<ScreenRoute: Route>: Routable {
    private let navigator: (ScreenRoute, Bool) -> Void

    public init<T: Routable>(_ router: T) where T.ScreenRoute == ScreenRoute {
        navigator = router.navigateTo
    }

    public func navigateTo(route: ScreenRoute, animated: Bool) {
        navigator(route, animated)
    }
}

extension Router: ReactiveCompatible {}

extension Routable {
    public func navigateTo(route: ScreenRoute) {
        navigateTo(route: route, animated: true)
    }
}

extension Reactive where Base: Routable {
    func navigateTo<ScreenRoute>(route: ScreenRoute) -> AnyObserver<Void>
    where Base.ScreenRoute == ScreenRoute {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.navigateTo(route: route)
            default: break
            }
        }
    }
}
