import SwiftUI
import UIKit

class FullScreenViewController: UIViewController {
    var cornerRadius: CGFloat = 0 {
        didSet {
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
        }
    }
    
    var backgroundColor: UIColor = .white {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    var dismissAction: (() -> Void)?
    
    private var initialPositionY: CGFloat = 0 // Pour garder la position initiale du geste

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        
        // Position initiale: En bas de l'écran pour démarrer la transition
        self.view.frame.origin.y = UIScreen.main.bounds.height
        
        // Ajouter le geste de pan pour permettre le drag
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func showFullScreenView() {
        // Animation pour faire apparaître la vue depuis le bas
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame.origin.y = 0 // Déplace la vue vers le haut
        })
    }
    
    func dismissFullScreenView() {
        // Animation pour faire disparaître la vue
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame.origin.y = UIScreen.main.bounds.height // Descend la vue en bas de l'écran
        }) { _ in
            self.dismissAction?() // Appel de l'action de fermeture après l'animation
        }
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let window = self.view?.window else { return }
        
        _ = sender.location(in: window)
        let velocity = sender.velocity(in: window)
        
        switch sender.state {
        case .began:
            // Sauvegarder la position initiale de la vue lorsque le geste commence
            initialPositionY = self.view.frame.origin.y
        case .changed:
            // Calculer la position de la vue en fonction du mouvement du geste
            let translation = sender.translation(in: window).y
            self.view.frame.origin.y = initialPositionY + translation
        case .ended, .cancelled:
            // Lorsque le geste se termine, vérifier la position de relâchement
            let releasePositionY = self.view.frame.origin.y
            if releasePositionY > (UIScreen.main.bounds.height / 3) || velocity.y > 500 {
                dismissFullScreenView() // Si la vue a été tirée plus de la moitié, la fermer
            } else {
                // Sinon, remettre la vue à sa position initiale
                showFullScreenView()
            }
        default:
            break
        }
    }
}
// `UIViewControllerRepresentable` pour intégrer `FullScreenViewController` dans SwiftUI
struct FullScreenCoverView<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var cornerRadius: CGFloat
    var backgroundColor: UIColor
    var content: Content
    
    init(isPresented: Binding<Bool>, cornerRadius: CGFloat = 0, backgroundColor: UIColor = .red, @ViewBuilder content: @escaping () -> Content) {
        self._isPresented = isPresented
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> FullScreenViewController {
        let viewController = FullScreenViewController()
        viewController.cornerRadius = cornerRadius
        viewController.backgroundColor = backgroundColor
        viewController.dismissAction = {
            withAnimation {
                self.isPresented = false
            }
        }
        
        // Ajouter la vue SwiftUI dans le ViewController UIKit
        let hostingController = UIHostingController(rootView: content)
        viewController.addChild(hostingController)
        hostingController.view.frame = viewController.view.bounds
        hostingController.view.backgroundColor = .clear
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: viewController)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: FullScreenViewController, context: Context) {
        uiViewController.cornerRadius = cornerRadius
        uiViewController.backgroundColor = backgroundColor
    }
}
extension View {
    func customFullScreenCover<Content: View>(isPresented: Binding<Bool>, cornerRadius: CGFloat = 0, backgroundColor: UIColor = .red, @ViewBuilder content: @escaping () -> Content) -> some View {
        
        ZStack {
            self // Vue principale
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.5) // Fond semi-transparent
                    .edgesIgnoringSafeArea(.all)
                
                FullScreenCoverView(isPresented: isPresented, cornerRadius: cornerRadius, backgroundColor: backgroundColor, content: content)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
