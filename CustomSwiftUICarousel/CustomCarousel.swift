
import SwiftUI

struct CustomCarousel: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    
    // # Private/Fileprivate
    
    // # Body
    var body: some View {
        
        ZStack {
            
            CarouselCell(text: "View 1")
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
// MARK: Subviews
//=======================================
private struct CarouselCell : View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    let text: String
        
    // # Body
    var body: some View {
        
        ZStack {
            
            Color.blue
                .opacity(0.15)
            Text(text)
        }
        .frame(width: 280, height: 420)
        .cornerRadius(20)
    }
}


//=======================================
// MARK: Previews
//=======================================
struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarousel()
    }
}
