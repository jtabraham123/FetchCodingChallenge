//
//  DessertImageViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import UIKit

// Loads image from the url and sets title of dessert


protocol DessertListItemViewModelDelegate: AnyObject {
    func didTapDessertItem(_ source: DessertListItemView.ViewModel)
}


extension DessertListItemView {
    
    class ViewModel: ViewModelType {
        var dessert: Dessert
        @Published var loadResult: Result<UIImage, Error>? = nil
        private let imageRepository: ImageRepository
        
        
        private weak var delegate: DessertListItemViewModelDelegate?
        
        init(dessert:Dessert, imageRepository: ImageRepository) {
            self.dessert = dessert
            self.imageRepository = imageRepository
            self.getImage()
        }
        
        func addDelegate(delegate: DessertListItemViewModelDelegate) {
            self.delegate = delegate
        }
        
        func tappedDessertItem() {
            self.delegate?.didTapDessertItem(self)
        }
        
        func getImage() {
            imageRepository.findImage(forKey: dessert.id, imageUrl: URL(string: dessert.thumbnail)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadResult = result
                }
            }
        }
    }
}
