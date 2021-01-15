
import SwiftUI

struct ContentView: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    // The strings in the carousel cells
    let viewTitles: Array = ["Cell 0", "Cell 1", "Cell 2", "Cell 3", "Cell 4"]
    
    // # Private/Fileprivate
    @State private var currentPage = 0
    
    // # Body
    var body: some View {
        
        VStack {
            
            Text("Hello, World!")
            CustomCarousel(viewTitles: viewTitles, size: CGSize(width: 100, height: 420), carouselLocation: $currentPage)
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
        ContentView()
    }
}
