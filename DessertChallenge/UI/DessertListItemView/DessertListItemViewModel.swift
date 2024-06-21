//
//  DessertImageViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import UIKit
import Combine
import SwiftUI



protocol DessertListItemViewModelDelegate: AnyObject {
    func didTapDessertItem(_ source: DessertListItemView.ViewModel)
}

// DessertListItemView.ViewModel publishes the result of the image loading from the imageLoadService/imageRepository and contains the dessert model for data presentation
extension DessertListItemView {
    
    class ViewModel: ViewModelType {
        var dessert: Dessert
        @Published var loadResult: Result<UIImage, Error>? = nil
        private var imageRepository: InMemoryImageRepository
        private var cancellables = Set<AnyCancellable>()
        
        
        private weak var delegate: DessertListItemViewModelDelegate?
        
        init(dessert:Dessert, imageRepository: InMemoryImageRepository) {
            self.dessert = dessert
            self.imageRepository = imageRepository
            self.subscribeToImageResult()
            self.getImage(retry: false)
        }
        
        func subscribeToImageResult() {
            let publisher = imageRepository.publisher(forKey: dessert.id)
            publisher.sink { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadResult = result
                }
            }
            .store(in: &cancellables)
            imageRepository.publishCurrentValueInCache(forKey: dessert.id, publisher: publisher)
        }
        
        func addDelegate(delegate: DessertListItemViewModelDelegate) {
            self.delegate = delegate
        }
        
        func tappedDessertItem() {
            self.delegate?.didTapDessertItem(self)
        }
        
        func getImage(retry: Bool) {
            imageRepository.findImage(forKey: dessert.id, imageUrl: URL(string: dessert.thumbnail), retry: retry)
        }
    }
}
