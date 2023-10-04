//
//  MoviewDetails.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import SwiftUI

struct MovieDetails: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text(viewModel.movie.title)
            Text(String(viewModel.movie.year))
            Spacer()
            Button(viewModel.isFavorite ? "Remove from favorites" : "Add to favorites") {
                viewModel.toggleFavorites()
            }
        }
        .onAppear {
            viewModel.refresh()
          }
    }
}

#Preview {
    MovieDetails(viewModel: MovieDetails.ViewModel(movie: Movie.mocked, favoriteService: FavoriteServiceMock()))
}
