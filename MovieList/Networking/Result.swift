//
//  Result.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
