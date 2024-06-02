import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtutorial/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/pokemon.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  PokemonListTile({required this.pokemonURL});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final pokemon = ref.watch(
      pokemonDataProvider(
        pokemonURL,
      ),
    );
    return pokemon.when(data: (data) {
      return _tile(context, false, data);
    }, error: (error, stackTrace) {
      return Text("Error: $error");
    }, loading: () {
      return _tile(context, true, null);
    });
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!))
            : CircleAvatar(),
        title: Text(pokemon != null
            ? pokemon.name!.toUpperCase()
            : "Currently loading name for pokemon"),
        subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0}"),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
