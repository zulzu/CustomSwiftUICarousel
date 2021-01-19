
import SwiftUI

struct ContentView: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    // The content of the carousel cells
    let carouselCells: CarouselViewModel
    
    // # Private/Fileprivate
    @State private var currentPage = 0
    
    // # Body
    var body: some View {
        
        VStack {
            
            Text("Hello carousel!")
            CustomCarousel(cellItems: carouselCells.carouselItem, size: CGSize(width: 280, height: 420), carouselLocation: $currentPage)
        }
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    
    //=======================================
    // MARK: Private Methods
    //=======================================
}


//=======================================
// MARK: Previews
//=======================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(carouselCells: CarouselViewModel.preview())
    }
}
