//
//  DessertImageViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import UIKit



protocol DessertListItemViewModelDelegate: AnyObject {
    func didTapDessertItem(_ source: DessertListItemView.ViewModel)
}

// DessertListItemView.ViewModel publishes the result of the image loading from the imageLoadService/imageRepository and contains the dessert model for data presentation
extension DessertListItemView {
    
    class ViewModel: ViewModelType {
        var dessert: Dessert
        @Published var loadResult: Result<UIImage, Error>? = nil
        private let imageRepository: ImageRepository
        
        
        private weak var delegate: DessertListItemViewModelDelegate?
        
        init(dessert:Dessert, imageRepository: ImageRepository) {
            self.dessert = dessert
            self.imageRepository = imageRepository
            self.getImage(retry: false)
        }
        
        func addDelegate(delegate: DessertListItemViewModelDelegate) {
            self.delegate = delegate
        }
        
        func tappedDessertItem() {
            self.delegate?.didTapDessertItem(self)
        }
        
        func getImage(retry: Bool) {
            if (retry) {
                DispatchQueue.main.async {
                    self.loadResult = nil
                }
            }
            imageRepository.findImage(forKey: dessert.id, imageUrl: URL(string: dessert.thumbnail)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadResult = result
                }
            }
        }
    }
}
