import Foundation

import SwiftUI
import UIKit

// MARK: SwiftUI Preview
#if DEBUG
@available(iOS 13.0, *)
struct ContentViewControllerContainerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ProfileViewController
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return UIViewControllerType()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        ContentViewControllerContainerView().colorScheme(.light) // or .dark
    }
}
#endif
