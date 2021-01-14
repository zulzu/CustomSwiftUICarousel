
import SwiftUI

struct CustomCarousel: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    
    // # Private/Fileprivate
    @GestureState private var dragState = DragState.inactive
    
    // # Body
    var body: some View {
        
        ZStack {
            
            CarouselCell(text: "View 1")
                .offset(x: cellOffset())

        }
        .gesture(
            DragGesture()
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded(onDragEnded)
        )
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    
    //=======================================
    // MARK: Private Methods
    //=======================================
    // For moving the cells with the DragGesture
    func cellOffset() -> CGFloat {
        
        return self.dragState.translation.width

    }
    
    // For all the actions that should happen after finished dragging
    private func onDragEnded(drag: DragGesture.Value) {
        
        print("drag ended")
    }
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
// MARK: Enums
//=======================================
enum DragState {
    
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        
        switch self {
        
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
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
