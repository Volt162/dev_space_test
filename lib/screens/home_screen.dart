import 'package:dev_space_test/blocs/home/bloc/home_bloc.dart';
import 'package:dev_space_test/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String image = 'assets/images/ds_logo.png';
  final ScrollController _scrollController = ScrollController();

  HomeScreen({super.key});

  void autoScrollToLatestItem() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 200));
  }

  Column _buildHomeScreenLayout(HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        // Logo
        Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Image.asset(image),
        ),
        //Item List
        ItemListView(items: state.itemList),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                  if (state is HomePageError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                }, builder: (context, state) {
                  if (state is HomePageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomePageItemListChanged) {
                    return _buildHomeScreenLayout(state);
                  } else {
                    // (state is HomePageError)
                    return _buildHomeScreenLayout(state);
                  }
                }),
              ),
            );
          },
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            context.read<HomeBloc>().add(IncrementItemList());
            autoScrollToLatestItem();
          },
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          onPressed: () {
            context.read<HomeBloc>().add(DecrementItemList());
            autoScrollToLatestItem();
          },
          child: const Icon(Icons.remove),
        )
      ]),
    );
  }
}
