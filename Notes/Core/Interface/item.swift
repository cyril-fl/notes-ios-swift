import SwiftUI

protocol ContentNode: Observable  {
    var name: String { get set}
    var path: String { get  set}
    var lastUpdateDate: Date { get set }
}
