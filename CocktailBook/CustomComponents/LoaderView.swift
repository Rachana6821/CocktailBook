//
//  LoaderView.swift
//  CocktailBook
//
//  Created by Rachana on 20/06/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.white
            .edgesIgnoringSafeArea(.all) // Semi-transparent background
             ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1, anchor: .center) // Adjust the size of the loader
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
