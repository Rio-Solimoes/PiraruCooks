//
//  MenuAPIService.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 02/05/24.
//

import Foundation
import SwiftUI

class MenuController: ObservableObject {
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        case imageDataMissing
    }

    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    static let shared = MenuController()

    let baseURL = URL(string: "http://localhost:8080/")!

    @Published var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }

    func fetchCategories() async throws -> [String] {
        let categoriesURL = baseURL.appendingPathComponent("categories")

        let (data, response) = try await URLSession.shared.data(from: categoriesURL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.categoriesNotFound
        }

        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)

        return categoriesResponse.categories
    }

    func fetchMenuItems(forCategory categoryName: String) async throws -> [MenuItem] {
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!

        let (data, response) = try await URLSession.shared.data(from: menuURL)

        // Debug: Print the received JSON data
        let jsonString = String(data: data, encoding: .utf8)
        print("Received JSON data: \(jsonString ?? "")")

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }

        let decoder = JSONDecoder()
        do {
            let menuResponse = try decoder.decode(MenuResponse.self, from: data)

            var fetchedMenuItems = menuResponse.items

            for i in 0..<fetchedMenuItems.count {
                fetchedMenuItems[i].image = try await fetchImage(from: fetchedMenuItems[i].imageURL)
            }

            return fetchedMenuItems
        } catch {
            // Debug: Print any decoding errors
            print("Error decoding menu items: \(error)")
            throw error
        }
    }

    func fetchImage(from url: URL) async throws -> Image {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuControllerError.imageDataMissing
        }

        guard let uiImage = UIImage(data: data) else {
            throw MenuControllerError.imageDataMissing
        }

        // Ensure that the image is created on the main thread
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                continuation.resume(returning: Image(uiImage: uiImage))
            }
        }
    }
}
