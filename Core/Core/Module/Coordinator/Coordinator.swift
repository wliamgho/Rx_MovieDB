//
//  Coordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxFramework

// V2
//protocol Coordinator: AnyObject {
//    var childCoordinators: [Coordinator] { get set }
//    func start() -> Observable<Void>
//
//    func coordinate(_ coordinator: Coordinator) -> Observable<Void>
//}
//
//extension Coordinator {
//    /// Add Chile Coodinator
//    func store(coordinator: Coordinator) {
//        childCoordinators.append(coordinator)
//    }
//
//    /// Release Child Coordinator
//    func free(coordinator: Coordinator) {
//        childCoordinators = childCoordinators.filter { $0 !== coordinator }
//    }
//}
//
//extension Coordinator where Self: ReactiveCompatible {
//    func coordinate(_ coordinator: Coordinator) -> Observable<Void> {
//        self.store(coordinator: coordinator)
//        return coordinator.start().do(onNext: { [weak self] _ in
//            self?.free(coordinator: coordinator)
//        })
//    }
//}


// V1
/// To coordinate which route should triggered
public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func start(with option: DeeplinkOption?)

    /// Trigger to release from coordinator
    var onFinish: Observable<Bool> { get }
}

public extension Coordinator {
    /// Add Chile Coodinator
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    /// Release Child Coordinator
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension Coordinator where Self: ReactiveCompatible {
    public func start<T: Coordinator>(child: T) {
        self.store(coordinator: child)
        child.onFinish.subscribe(onNext: { [weak self] _ in
            self?.free(coordinator: child)
        }).disposed(by: rx.disposeBag)
    }
}
