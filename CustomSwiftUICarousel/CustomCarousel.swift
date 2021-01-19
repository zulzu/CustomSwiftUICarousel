
import SwiftUI

struct CustomCarousel: View {
    
    //------------------------------------
    // MARK: Properties
    //------------------------------------
    // # Public/Internal/Open
    // The content of the carousel cells
    let cellItems: Array<CarouselCellItem>
    // The size of the carousel cells
    let size: CGSize
    // Can set the secondary cells 20% smaller than the main cell
    let isScalable: Bool?
    // A binding to determine the main cell of the carousel
    @Binding var carouselLocation: Int
    
    // # Private/Fileprivate
    // Creates a view state that's derived from a gesture.
    @GestureState private var dragState = DragState.inactive
    // The direction of the drag
    @State private var isMovedLeft: Bool = false
    
    // # Body
    var body: some View {
        
        ZStack {
            
            ForEach(0..<cellItems.count) { (idx) in
                CarouselCell(cellItem: cellItems[idx], size: size)
                    .offset(x: cellOffset(cellLocation(idx)))
                    .scaleEffect(idx == carouselLocation || !(isScalable ?? true) ? 1.0 : 0.8)
                    .animation(animationControl(idx))
            }
            
            //                        ForEach(0..<viewTitles.count) { (idx)  in
            //                            Text("CelLoc: \(cellLocation(idx)), CarLoc \(carouselLocation)")
            //                                .offset(x: cellOffset(cellLocation(idx)))
            //                                .padding(.top, size.height * 0.7)
            //                                .scaleEffect(idx == carouselLocation || !(isScalable ?? true) ? 1.0 : 0.8)
            //                                .animation(animationControl(idx))
            //                        }
        }
        .gesture(
            DragGesture()
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onChanged({ gesture in
                    dragHappening(drag: gesture)
                })
                .onEnded(onDragEnded)
        )
    }
    
    //=======================================
    // MARK: Public Methods
    //=======================================
    /// An instance of an infinite carousel
    /// - Parameters:
    ///   - cellItems: The content of the carousel cells
    ///   - size: The size of the carousel cells
    ///   - isScalable: Can set the secondary cells 20% smaller than the main cell
    ///   - carouselLocation: A binding to determine the main cell of the carousel
    public init(cellItems: [CarouselCellItem], size: CGSize, isScalable: Bool? = true, carouselLocation: Binding<Int>) {
        self.cellItems = cellItems
        self.size = size
        self.isScalable = isScalable
        self._carouselLocation = carouselLocation
    }
    
    //=======================================
    // MARK: Private Methods
    //=======================================
    /* Turning the animations on/off
     When the carousel makes a full turn, the out-of-screen cells are moving to the other side of the screen to make the carousel infinite. If the animation is on when this happens, we can see these cells move through the screen for a split second (depending on the duration of the animation). Turning off the animations for these cells puts them to the correct position instantly.
     */
    private func animationControl(_ idx: Int) -> Animation? {
        if cellLocation(idx) > carouselLocation && isMovedLeft {
            return nil
        } else if cellLocation(idx) < carouselLocation && !isMovedLeft {
            return nil
        } else {
            return Animation.easeInOut(duration: 0.1)
        }
    }
    
    // For moving the cells with the DragGesture
    private func cellOffset(_ cellPosition: Int) -> CGFloat {
        
        // The distance between the cells
        let cellDistance: CGFloat = (size.width / (isScalable ?? true ? 0.87 : 1)) + 20
        
        if cellPosition == carouselLocation {
            // Offset of the main cell
            return self.dragState.translation.width
        } else if cellPosition < carouselLocation {
            // Offset on the left
            return self.dragState.translation.width - (cellDistance * CGFloat(carouselLocation - cellPosition))
        } else {
            // Offset on the right
            return self.dragState.translation.width + (cellDistance * CGFloat(cellPosition - carouselLocation))
        }
    }
    
    // For checking the direction of the movement while dragging
    private func dragHappening(drag: DragGesture.Value) {
        
        if drag.startLocation.x > drag.location.x {
            isMovedLeft = true
        } else {
            isMovedLeft = false
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
                carouselLocation = cellItems.count - 1
            }
        }
        // Swiping left increases the location by one, when it reaches the highest possible value, it resets to zero
        else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            carouselLocation =  carouselLocation + 1
            if carouselLocation == cellItems.count {
                carouselLocation = 0
            }
        }
        print("Carousel location: \(carouselLocation)")
    }
    
    // For identifying the position of the cells in the carousel
    private func cellLocation(_ idx: Int) -> Int {
        
        if (carouselLocation == 0) && (idx + 1 == cellItems.count) {
            // The cell is on the left side
            return -1
        } else if (carouselLocation == cellItems.count - 1) && (idx == 0) {
            // The cell is on the right side
            return cellItems.count
        } else {
            // The main cell
            return idx
        }
        
        // TODO: mix the two versions AND avoid extra if statements
        // This works nicely with 5+ carousel cells, but not at all with less than 5
        //        if (carouselLocation == 0) && (idx + 2 >= viewTitles.count) {
        //            // The cell is on the left side
        //            return idx - viewTitles.count
        //        } else if (carouselLocation >= viewTitles.count - 2) && (idx < 2) {
        //            // The cell is on the right side
        //            return idx + viewTitles.count
        //        } else {
        //            // The main cell
        //            return idx
        //        }
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
    // The content of the cell
    let cellItem: CarouselCellItem
    // The size of the cell
    let size: CGSize
    
    // # Body
    var body: some View {
        
        ZStack {
            
            cellItem.colour
            
            VStack {
                
                Text(cellItem.title)
                    .padding()
                Text(cellItem.text)
                    .padding()
                Spacer()
            }
        }
        .frame(width: size.width, height: size.height)
        .cornerRadius(cellItem.cornerRadius)
    }
}


//=======================================
// MARK: Previews
//=======================================
struct CustomCarousel_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomCarousel(
            cellItems: [
                CarouselCellItem(title: "Main title 1", colour: Color.red, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", cornerRadius: 25),
                CarouselCellItem(title: "Main title 2", colour: Color.green, text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", cornerRadius: 25),
                CarouselCellItem(title: "Main title 3", colour: Color.blue, text: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.", cornerRadius: 25),
                CarouselCellItem(title: "Main title 4", colour: Color.yellow, text: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.", cornerRadius: 25),
                CarouselCellItem(title: "Main title 5", colour: Color.purple, text: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", cornerRadius: 25),
            ],
            size: CGSize(width: 280, height: 420),
            isScalable: false,
            carouselLocation: Binding.constant(1))
    }
}
