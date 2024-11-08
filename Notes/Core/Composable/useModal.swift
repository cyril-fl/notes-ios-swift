import SwiftUI

@Observable
class useModal: ObservableObject {
    
    var isPresented: Bool = false
    
    var content:  AnyView? = nil
    
    func dsiplay() {
        isPresented.toggle()
        //...AnyView(content ?? EmptyView())
    }
}
