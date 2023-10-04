//
//  FavoritesView.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 01.10.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.favorites) { movie in
                    Text(movie.title)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.select(movie: movie)
                        }
                }
                
            }
            .onAppear {
                viewModel.refresh()
              }
        }
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesView.ViewModel(favoritesService: FavoriteServiceMock()))
}
