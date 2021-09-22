//
//  Service.swift
//  Music Bag
//
//  Created by Premier on 25/08/21.
//

import Foundation

protocol Service {
    typealias Completion<T> = (_ result: Result<T, Error>) -> ()
}
