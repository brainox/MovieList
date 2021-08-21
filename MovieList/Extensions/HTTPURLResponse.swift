//
//  HTTPURLResponse.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
