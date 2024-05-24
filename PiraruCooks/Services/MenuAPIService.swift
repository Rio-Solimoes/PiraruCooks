//
//  MenuAPIService.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 02/05/24.
//

import Foundation
import SwiftUI

@Observable
class MenuController {
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        case imageDataMissing
    }
    
    var categories = [String]()
    var dishes = [MenuItem]()
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    static let shared = MenuController(mocked: true)
    private let baseURL = URL(string: "http://localhost:8080/")!
    
    init() {
        fetchInitialData()
    }
    
    init(mocked: Bool = false) {
        if mocked {
            fetchMockedData()
        } else {
            fetchInitialData()
        }
    }
    
    func fetchInitialData() {
        Task {
            do {
                let fetchedCategories = try await fetchCategories()
                
                // swiftlint:disable:next line_length
                let fetchResults = try await withThrowingTaskGroup(of: [MenuItem].self) { group -> (fetchedDishes: [MenuItem], nonEmptyCategories: [String]) in
                    for category in fetchedCategories {
                        group.addTask {
                            try await self.fetchMenuItems(forCategory: category)
                        }
                    }
                    var fetchedDishes: [MenuItem] = []
                    var nonEmptyCategories: [String] = []
                    for try await dishes in group {
                        if let dish = dishes.first {
                            nonEmptyCategories.append(dish.category)
                            fetchedDishes.append(contentsOf: dishes)
                        }
                    }
                    return (fetchedDishes, nonEmptyCategories)
                }
                
                let orderedNonEmptyCategories = fetchResults.nonEmptyCategories.sorted(by: {(categoryA, categoryB) in
                    if let indexA = fetchedCategories.firstIndex(of: categoryA),
                        let indexB = fetchedCategories.firstIndex(of: categoryB) {
                        return indexA < indexB
                    }
                    return false
                })

                DispatchQueue.main.async {
                    self.categories = orderedNonEmptyCategories
                    self.dishes = fetchResults.fetchedDishes
                }
            } catch {
                //print("Error fetching initial data: \(error)")
            }
        }
    }

    private func fetchCategories() async throws -> [String] {
        let categoriesURL = baseURL.appendingPathComponent("categories")

        let (data, response) = try await URLSession.shared.data(from: categoriesURL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.categoriesNotFound
        }

        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)

        return categoriesResponse.categories
    }

    private func fetchMenuItems(forCategory categoryName: String) async throws -> [MenuItem] {
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!

        let (data, response) = try await URLSession.shared.data(from: menuURL)

        let jsonString = String(data: data, encoding: .utf8)
        //print("Received JSON data: \(jsonString ?? "")")

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }

        let decoder = JSONDecoder()
        do {
            let menuResponse = try decoder.decode(MenuResponse.self, from: data)

            var fetchedMenuItems = menuResponse.items

            for item in 0..<fetchedMenuItems.count {
                fetchedMenuItems[item].image = try await fetchImage(from: fetchedMenuItems[item].imageURL)
            }

            return fetchedMenuItems
        } catch {
            //print("Error decoding menu items: \(error)")
            throw error
        }
    }

    private func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MenuControllerError.imageDataMissing
        }

        if httpResponse.statusCode != 200 {
            //print("Image fetch failed with status code: \(httpResponse.statusCode)")
            throw MenuControllerError.imageDataMissing
        }

        if let image = UIImage(data: data) {
            return image
        } else {
            //print("Failed to create UIImage from data")
            throw MenuControllerError.imageDataMissing
        }
    }

    func fetchMockedData() {
        guard let menuItemsUrl = Bundle.main.url(forResource: "menuItems", withExtension: "json") else {
            print("categories JSON not found")
            return
        }
        do {
            let menuItemsData = try Data(contentsOf: menuItemsUrl)
            var menuItems = try JSONDecoder().decode([MenuItem].self, from: menuItemsData)
            var categories = [String]()
            for item in 0..<menuItems.count {
                menuItems[item].image = UIImage(named: menuItems[item].imageURL.absoluteString)
                if !categories.contains(where: { category in category == menuItems[item].category }) {
                    categories.append(menuItems[item].category)
                }
            }
            self.categories = categories.sorted(by: {(categoryA, categoryB) in
                if let indexA = categories.firstIndex(of: categoryA),
                    let indexB = categories.firstIndex(of: categoryB) {
                    return indexA < indexB
                }
                return false
            })
            self.dishes = menuItems
        } catch {
            print("Error loading JSON:", error)
        }
    }
}
