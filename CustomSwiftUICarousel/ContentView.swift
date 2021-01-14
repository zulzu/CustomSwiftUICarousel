
import SwiftUI

struct ContentView: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    
    // # Private/Fileprivate
    
    // # Body
    var body: some View {
        
        VStack {
            
            Text("Hello, World!")
            CustomCarousel()
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
