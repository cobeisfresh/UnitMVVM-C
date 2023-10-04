//
//  MovieList.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Refresh") {
                    Task {
                        await viewModel.loadMovies()
                    }
                }
            }
 
            Spacer()
            if let errorText = viewModel.error {
                Text(errorText)
                    .foregroundStyle(.red)
            }
            Spacer()
            List {
                ForEach(viewModel.movies) { movie in
                    Text(movie.title)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.select(movie: movie)
                        }
                }
                
            }
            Spacer()
        }
//        .task {
//            await viewModel.loadMovies()
//        }
    }
}

#Preview {
    MovieList(viewModel: MovieList.ViewModel(moviesService: MovieService()))
}
