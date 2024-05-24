//
//  HomeInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  // without combine
  // func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
  
  /// with combine
  func getCategories() -> AnyPublisher<[CategoryModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return repository.getCategories()
  }
}
