import SwiftUI

protocol ContentNode  {
    var name: String { get set}
    var path: String { get  set}
    var lastUpdateDate: Date { get set }
}
protocol Displayable {
    var display: DisplayMode { get set }
}





//TODO suprimer ce protocol
protocol Searchable {
    var content: String { get }
}
