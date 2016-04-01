//
//  Or.swift
//  MARS-iOS-app
//
//  Created by Thang Le on 3/31/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

enum Or<L, R> {
    case Left(L)
    case Right(R)
    
    func isRight() -> Bool {
        return self.fold({ _ in false }, { _ in true })
    }
    
    func isLeft() -> Bool {
        return self.fold({ _ in true }, { _ in false })
    }
    
    func fold<T>(fl: L -> T, _ fr: R -> T) -> T {
        switch self {
        case .Left(let l):
            return fl(l)
        case .Right(let r):
            return fr(r)
        }
    }
    
    func map<T>(f: R -> T) -> Or<L, T> {
        switch self {
        case .Left(let l):
            return .Left(l)
        case .Right(let r):
            return .Right(f(r))
        }
    }
    
    func leftMap<T>(f: L -> T) -> Or<T, R> {
        switch self {
        case .Left(let l):
            return .Left(f(l))
        case .Right(let r):
            return .Right(r)
        }
    }
    
    func flatMap<T>(f: R -> Or<L, T>) -> Or<L, T> {
        switch self {
        case .Left(let l):
            return .Left(l)
        case .Right(let r):
            return f(r)
        }
    }
    
    func getOrElse(default_: R) -> R {
        return self.fold({ _ in default_ }, { r in r })
    }
}