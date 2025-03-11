# Adidas Store - SwiftUI MVVM Demonstration
Overview

  Adidas Store is a demonstration project showcasing the use of SwiftUI with the MVVM architecture in an iOS application. The app provides a simple e-commerce experience, allowing users to browse a list of Adidas products, view product details, add items to their cart, apply promotional codes, and proceed to checkout before placing an order.

Features

- Product Listing: Browse a collection of Adidas products with images, descriptions, and prices.

- Product Details: View detailed information about a selected product.

- Cart Management: Add products to the cart and manage cart contents.

- Promotion & Discounts: Apply promotional codes to receive discounts.

- Checkout Process: Review the order summary and proceed to checkout.

Architecture

This project follows the MVVM (Model-View-ViewModel) architecture, ensuring a clean separation of concerns and better code maintainability.

Model: Defines the product, cart, and order data structures.

ViewModel: Handles business logic, data fetching, and state management.

View: SwiftUI views that present the UI and bind to ViewModel data.

Technologies Used

SwiftUI: Declarative UI framework for building modern iOS apps.

Combine: Reactive programming framework for handling data flow.

Xcode: Developed using Xcode for iOS deployment.


Installation

Clone the repository:

git clone https://github.com/028928768/adidas-shopping-ios

Open the project in Xcode:

cd adidas-store-swiftui
open AdidasStore.xcodeproj

Build and run the project on a simulator or a physical iOS device.

Screenshots

![Uploading Simulator Screenshot - iPhone 15 Pro - 2025-03-11 at 12.26.13.png…]()

![Uploading Simulator Screenshot - iPhone 15 Pro - 2025-03-11 at 12.26.57.png…]()
![Uploading Simulator Screenshot - iPhone 15 Pro - 2025-03-11 at 12.27.42.png…]()
![Uploading Simulator Screenshot - iPhone 15 Pro - 2025-03-11 at 12.27.06.png…]()



Future Enhancements

Implement real-time API fetching for product listings.

Add user authentication for personalized shopping experience.

Enhance UI with animations and additional UX improvements.

License

This project is licensed under the MIT License.
