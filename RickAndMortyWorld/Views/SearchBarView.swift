//
//  SearchBarView.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 24.08.21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State var placeholder: String
    
    @State private var editing = false
    
    init(searchText: Binding<String>, placeholder: String = "") {
        self._searchText = searchText
        self._placeholder = State(wrappedValue: placeholder)
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.lightGray))
                    .frame(maxWidth: 25)
                TextField(
                    placeholder,
                    text: $searchText,
                    onCommit:  { hideKeyboard() }
                )
                .padding(.vertical, 6)
                
                if editing {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.lightGray))
                            .padding(.trailing, 6)
                    }
                }
            }
            .background(Color(.init(gray: 0.6, alpha: 0.2)))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .onTapGesture { editing = true }
            
            if editing {
                Button {
                    searchText = ""
                    editing = false
                    hideKeyboard()
                } label: {
                    Text("Cancel")
                        .font(.callout)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Test"))
    }
}
