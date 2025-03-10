//
//  APIServices.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

class APIServices {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        // Mock data instead of an actual network request
        let mockProducts: [Product] = [
            Product(id: 1, model: "ADIZERO ADIOS PRO 4", price: 8000.00, rating: 4, gender: "Men", size: "8 UK", category: "Performance", isInStock: true, title: "LIGHTWEIGHT DISTANCE RUNNING SHOES DESIGNED TO BREAK RECORDS", description: "Proven to be the world's most winning shoe, the Adizero Adios Pro line is the pinnacle of Adizero Racing shoes. The Adios Pro 4 is made for fast runners who want to experience faster, with enhanced features designed to optimize running efficiency. Our carbon-infused ENERGYRODS 2.0 provide a seamless transition from heel to toe for a snappy, efficient stride. In the midsole, a new rocker point offers improved running economy. A double layer of our best-in-class ultralight LIGHTSTRIKE PRO ensures cushioning for every quick stride you take, helping you maintain energy over the long term. The shoe rides on an outsole built with Continental™ rubber for a no-slip transition during toe-off, as well as LIGHTTRAXION, designed to reduce weight without sacrificing grip."),
            
            Product(id: 2, model: "Ultraboost 5 Shoes", price: 6700.00, rating: 5, gender: "Men", size: "7.5 UK", category: "Running", isInStock: true, title: "BOOST Running shoes made in part with recycled materials.", description: "Innovated for more cushion, more comfort and less weight for a run like no other, the Ultraboost 5 is here to harness your running energy. This shoe's midsole is made with Light BOOST V2, our highest energy return cushioning system. Ultraboost 5 also features moulded external heel support to provide optimised support where it's needed. The PRIMEKNIT upper creates the ultimate fit while our Torsion System provides next level guidance all the way through your gait. And finally, the world-class grip of the Continental™ outsole enables the perfect traction and transition."),
            
            Product(id: 3, model: "Adizero Takumi Sen 10 Shoes", price: 8000.00, rating: 4, gender: "Men", size: "8 UK", category: "Performance", isInStock: true, title: "RACE-DAY RUNNING SHOES FOR A FAST 10K.", description: "Chase your fastest 10k in our latest Adizero racing shoes, built exclusively for speed. The Adizero Takumi Sen 10 have been designed with two layers of LIGHTSTRIKE PRO cushioning, combined with ENERGYRODS for stiff and snappy toe-offs as you transition from corners to straights. Get to the finish line in your fastest time yet."),
            
            Product(id: 4, model: "Crazychaos 2000 Shoes", price: 2600.00, rating: 4, gender: "Men", size: "8 UK", category: "Sportwear", isInStock: true, title: "Classic sneakers built for comfort and breathability.", description: "Step into comfort and make a stylish statement with the adidas Crazychaos 2000 shoes. Their breathable mesh upper lets your feet breathe easy while the Cloudfoam midsole cushions each step with pillowy softness. Whether wandering city streets or kicking back at your favourite coffee shop, the versatile design pairs perfectly with everything from joggers to jeans."),
            
            Product(id: 5, model: "Adidas Gazelle Indoor Shoes", price: 4300.00, rating: 3, gender: "Men", size: "7.5 UK", category: "Original", isInStock: true, title: "Low-profile shoes rooted in adidas heritage.", description: "These adidas Gazelle Indoor Shoes are a modern take on a '70s icon. The sleek leather upper provides a stylish, premium look while the synthetic lining keeps feet comfortable all day. Originally designed as a lightweight training shoe, the Gazelle has since become a lifestyle staple. Its retro-inspired style transitions effortlessly from work to play."),
            
            Product(id: 6, model: "Handball Spezial Shoes", price: 3800.00, rating: 5, gender: "Men", size: "8 UK", category: "Originals", isInStock: true, title: "This low-profile trainer brings energy and comfort to your style game.", description: "Originally designed for fast-paced indoor sports, these adidas Handball Spezial Shoes playing days are done but keep your style game strong. Crafted for comfort, their leather and textile upper surrounds a synthetic lining. Underneath, a rubber outsole maintains grip on city streets and beyond. A timeless T-toe classic, the Spezial stands out with serrated 3-Stripes and gold-letter branding along the side. Bring the energy and attitude of sport to your everyday hustle with these iconic low-profile trainers."),
            
            Product(id: 7, model: "Adizero Adios 9 Running Shoes", price: 5300.00, rating: 4, gender: "Men", size: "8 UK", category: "Running", isInStock: false, title: "Low-stack, race-ready running shoes made in part with recycled materials.", description: "There are 13.1 miles between you and the finish line. Get there in record time in these adidas running shoes. Light, fast and powered by a full-length Lightstrike Pro midsole, they're ready for training runs or race day. A small stiffening element in the midsole supports fast transitions, and a stretch mesh upper enhances comfort."),
            
            Product(id: 8, model: "Duramo SL 2 Running Shoes", price: 8000.00, rating: 4, gender: "Men", size: "8 UK", category: "Running", isInStock: true, title: "Lightweight running shoes for short-to-mid-distance training.", description: "You signed up for your first race. Now it's time to train. As you build consistency, speed and endurance, these adidas running shoes support you — one run at a time. They're light and stable with a breezy mesh upper and a full-length LIGHTMOTION midsole that responds to your stride. A durable Adiwear outsole grips the pavement or track.")
        ]
        
        // Simulate a network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(mockProducts))
        }
        
    }
}
