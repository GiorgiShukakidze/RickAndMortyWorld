//
//  Extensions.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import SwiftUI

extension View {
    func fetchErrorAlert(
        isPresented: Binding<Bool>,
        message: String,
        title: String = Constants.StaticTexts.fetchErrorMessage
    ) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(title: Text(title), message: Text(message))
        }
    }
    
    func popToRootView() {
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController?
            .navigationController()?
            .popToRootViewController(animated: true)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIViewController {
    func navigationController() -> UINavigationController? {
        if let navigationController = self as? UINavigationController {
            return navigationController
        }
        
        for childViewController in children {
            return childViewController.navigationController()
        }
        
        return nil
    }
}

extension Image {
    func avatarImageStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(.lightGray))
    }
}

extension UIImage {
    static func from(_ urlString: String, _ imageContent: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: urlString),
               let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    imageContent(UIImage(data: imageData))
                }
            }
            else {
                imageContent(nil)
            }
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
