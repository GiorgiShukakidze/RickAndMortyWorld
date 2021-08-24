//
//  SupportingViews.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import SwiftUI

struct PopToRootButton: View {
    var body: some View {
        Button(action: {
            popToRootView()
        }, label: {
            Image(systemName: "house.fill")
                .foregroundColor(Color("RickColor"))
        })
    }
}

struct HTitleDescriptionText: View {
    @State var title: String
    @State var description: String
    @State var font: Font?
    @State var alignment: Alignment = .left
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Text(description)
                .font(font ?? .title3)
            if alignment == .left {
                Spacer()
            }
        }
    }
    
    enum Alignment {
        case centered
        case left
    }
}

struct VTitleDescriptionText: View {
    @State var title: String
    @State var description: String
    @State var font: Font?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            Text(description)
                .font(font ?? .title3)
        }
    }
}

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

struct NavigatableListView<Content: View, Destination: View>: View {
    @State var withNavigation: Bool
    @State var destination: Destination
    @ViewBuilder var content: () -> Content
    
    init(withNavigation: Bool = true, destination: Destination, @ViewBuilder content: @escaping () -> Content) {
        self._withNavigation = State(initialValue: withNavigation)
        self._destination = State(initialValue: destination)
        self.content = content
    }
    
    var body: some View {
        if withNavigation {
            NavigationLink(
                destination: destination) {
                content()
            }
            .isDetailLink(false)
        } else {
            content()
        }
    }
}

struct AvatarImage: View {
    @Binding var image: UIImage?
    
    var body: some View {
        if image == nil {
            Image(systemName: "photo")
                .avatarImageStyle()
        }
        if let uiImage = image {
            Image(uiImage: uiImage)
                .avatarImageStyle()
        }
    }
}

struct LoadingOverlay: View {
    @Binding var show: Bool
    
    var body: some View {
        if show {
            Color(.gray)
                .opacity(0.5)
                .ignoresSafeArea()
        }
    }
}

struct LoadingMoreCell: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("Loading more...")
                .foregroundColor(.blue)
            Spacer()
        }
    }
}

struct RetryButton: View {
    var refreshAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: { refreshAction() }) {
                Label(
                    title: { Text("Reload").font(.callout.bold()) },
                    icon: { Image(systemName: "arrow.clockwise") }
                )
            }
            .padding(8)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color("RickColor")))
            .padding(.horizontal)
        }
    }
}
