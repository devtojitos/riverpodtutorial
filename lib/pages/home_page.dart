import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtutorial/controller/home_page_controller.dart';
import 'package:riverpodtutorial/models/page_data.dart';
import 'package:riverpodtutorial/models/pokemon.dart';
import 'package:riverpodtutorial/widgets/pokemon_list_tile.dart';

final HomePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>((ref) {
  return HomePageController(HomePageData.initial());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _allPokemonListScrollController = ScrollController();
  late HomePageController _homePageController;
  late HomePageData _homePageData;

  @override
  void initState() {
    super.initState();
    _allPokemonListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _allPokemonListScrollController.removeListener(_scrollListener);
    _allPokemonListScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_allPokemonListScrollController.offset >=
            _allPokemonListScrollController.position.maxScrollExtent * 1 &&
        !_allPokemonListScrollController.position.outOfRange) {
      print("end of list reached");

      _homePageController.loadData();

    }
  }

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(HomePageControllerProvider.notifier);
    _homePageData = ref.watch(HomePageControllerProvider);
    return Scaffold(
      body: _buildUI(
        context,
      ),
    );
  }

  Widget _buildUI(
    BuildContext context,
  ) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _allPokemonList(context),
          ],
        ),
      ),
    ));
  }

  Widget _allPokemonList(
    BuildContext context,
  ) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Pokemons",
            style: TextStyle(fontSize: 60),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: ListView.builder(
              controller: _allPokemonListScrollController,
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult? pokemon =
                    _homePageData.data?.results![index];
                return PokemonListTile(pokemonURL: pokemon!.url!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
