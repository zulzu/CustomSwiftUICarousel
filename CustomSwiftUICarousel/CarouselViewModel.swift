
import SwiftUI

struct CarouselViewModel {
    
    let carouselItem: [CarouselCellItem]
}

extension CarouselViewModel {
    static func preview() -> CarouselViewModel {
        CarouselViewModel(carouselItem: [
            
            CarouselCellItem(title: "Main title 1", colour: Color.red, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            CarouselCellItem(title: "Main title 2", colour: Color.green, text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."),
            CarouselCellItem(title: "Main title 3", colour: Color.blue, text: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."),
            CarouselCellItem(title: "Main title 4", colour: Color.yellow, text: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem."),
            CarouselCellItem(title: "Main title 5", colour: Color.purple, text: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        ])
    }
}
