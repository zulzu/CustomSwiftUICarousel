
import SwiftUI

struct CustomCarousel: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    // The strings in the carousel cells
    let viewTitles: Array = ["Cell 0", "Cell 1", "Cell 2", "Cell 3"]
    // The size of the carousel cells
    let size: CGSize
    // The identifing the main cell of the carousel
    @Binding var carouselLocation: Int
    
    // # Private/Fileprivate
    // Creates a view state that's derived from a gesture.
    @GestureState private var dragState = DragState.inactive
    
    // # Body
    var body: some View {
        
        ZStack {
            
            ForEach(0..<viewTitles.count) { (idx) in
                CarouselCell(text: viewTitles[idx], size: size)
                    .offset(x: cellOffset(cellLocation(idx)))
            }
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
    func cellOffset(_ cellPosition: Int) -> CGFloat {
        
        // The distance between the cells
        let cellDistance: CGFloat = size.width + 20
        
        if cellPosition == carouselLocation {
            // Offset of the main cell
            return self.dragState.translation.width
        } else if cellPosition == carouselLocation - 1 {
            // Offset of the very next cell on the left
            return self.dragState.translation.width - cellDistance
        } else if cellPosition < carouselLocation - 1 {
            // Offset of all the other cells on the left
            return self.dragState.translation.width - (cellDistance * 2)
        } else  if cellPosition == carouselLocation + 1 {
            // Offset of the very next cell on the right
            return self.dragState.translation.width + cellDistance
        } else {
            // Offset of the all the other cells on the right
            return self.dragState.translation.width + cellDistance * 2
        }
    }
    
    // For all the actions that should happen after finished dragging
    private func onDragEnded(drag: DragGesture.Value) {
        
        // The minimum dragging distance needed for changing between the cells
        let dragThreshold: CGFloat = size.width * 0.6
        
        // Swiping right decreases the location by one, when that goes below zero, the counter resets to the highest possible value determined by the number of the cells
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
            carouselLocation =  carouselLocation - 1
            if carouselLocation < 0 {
                carouselLocation = viewTitles.count - 1
            }
        }
        // Swiping left increases the location by one, when it reaches the highest possible value, it resets to zero
        else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            carouselLocation =  carouselLocation + 1
            if carouselLocation == viewTitles.count {
                carouselLocation = 0
            }
        }
        print("Carousel location: \(carouselLocation)")
    }
    
    // For identifying the position of the cells in the carousel
    func cellLocation(_ idx: Int) -> Int {
        
        if (carouselLocation == 0) && (idx + 1 == viewTitles.count) {
            // The cell on the left side
            return -1
        } else if (carouselLocation == viewTitles.count - 1) && (idx == 0) {
            // The cell on the right side
            return viewTitles.count
        } else {
            // The main cell
            return idx
        }
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
    // The sting shown in the view
    let text: String
    // The size of the cell
    let size: CGSize
    
    // # Body
    var body: some View {
        
        ZStack {
            
            Color.blue
                .opacity(0.15)
            Text(text)
        }
        .frame(width: size.width, height: size.height)
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
        
        if case let .dragging(translation) = self {
            return translation
        }
        return .zero
    }
}


//=======================================
// MARK: Previews
//=======================================
struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarousel(size: CGSize(width: 280, height: 420), carouselLocation: Binding.constant(1))
    }
}
