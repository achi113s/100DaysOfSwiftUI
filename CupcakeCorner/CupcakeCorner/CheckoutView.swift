//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Giorgio Latour on 4/27/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderClass: OrderClass
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(orderClass.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("An Error Occurred", isPresented: $showingErrorAlert) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }
    
    
    // The 'async' indicates this function can go to sleep while some code inside it,
    // which may take a long time to run, is running.
    // The code that can take a second to run is then labeled with 'await', meaning
    // that we are aware a sleep might happen.
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderClass) else {
            print("Failed to encode order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderClass.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.order.quantity)x \(Order.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errorMessage = error.localizedDescription.capitalized
            showingErrorAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orderClass: OrderClass())
        }
    }
}
