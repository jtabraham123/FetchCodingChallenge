//
//  ViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/11/24.
//


import Foundation

typealias ViewModelDefinition = (ObservableObject & Identifiable & Hashable)
// view model type definition, addded some conformities like Identifiable (for appending to navigation path) and Hashable for storing in a hashmap
protocol ViewModelType: ViewModelDefinition {}

extension ViewModelType {
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs === rhs
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
