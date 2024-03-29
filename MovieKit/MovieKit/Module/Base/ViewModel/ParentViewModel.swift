//
//  ParentViewModel.swift
//  MovieDB
//
//  Created by William on 30/04/22.
//

import RxSwift
import RxFramework
import RxCocoa

open class ParentViewModel {
    public lazy var disposeBag = DisposeBag()
    public init() {}

    // MARK: - ViewController Lifecycle
    /// didLoad: Using `viewDidLoad` ViewController lifecycle
    open func didLoad() {}
    /// didLoad: Using `viewWillAppear` ViewController lifecycle
    open func willAppear() {}
    /// didLoad: Using `viewDidDisappear` ViewController lifecycle
    open func didDisappear() {}
}
