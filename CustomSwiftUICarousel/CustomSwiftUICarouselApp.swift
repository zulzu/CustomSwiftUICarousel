
import SwiftUI

@main
struct CustomSwiftUICarouselApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView(carouselCells: CarouselViewModel.preview())
        }
    }
}
