//
//  FoodNetworking.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 17.05.2024.
//
import UIKit

protocol FoodViewDelegate: AnyObject {
    func displayFoodItems(_ items: [FoodItem])
    func displayError(_ error: String)
}
class FoodPresenter {
    weak var delegate : FoodViewDelegate?
    
    func loadItems() {
        fetchFoodItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items) :
                    self?.delegate?.displayFoodItems(items)
                case .failure(let error) :
                    self?.delegate?.displayError(error.localizedDescription)
                }
            }
            
        }
    }
    private func fetchFoodItems(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        let urlString = "https://neobook.online/coffeshop/products/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Response: \(response)")
            if let error = error {
                print("Network request failed: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Root.self, from: data)
                print("Decoded items: \(decodedData.results.count)")
                completion(.success(decodedData.results))
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
