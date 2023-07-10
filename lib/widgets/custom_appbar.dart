import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Cinemapedia",
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      /*final searchQuery = ref.read(searchQueryprovider);
                      final searchedMovies = ref.read(searchedMoviesProvider);
                      showSearch<Movie?>(
                              query: searchQuery,
                              context: context,
                              delegate: SearchMovieDelegate(
                                  initialMovies: searchedMovies,
                                  searchMovies: ref
                                      .read(searchedMoviesProvider.notifier)
                                      .searchMoviesByQuery))
                          .then((value) {
                        if (value != null) {
                          context.push('/home/0/movie/${value.id}');
                        }
                      }); //se manda la referencia*/
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
