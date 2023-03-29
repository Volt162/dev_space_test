import 'package:flutter/material.dart';

class ItemListView extends StatelessWidget {
  static const double gridSpacing = 15.0;
  final List<String> items;

  const ItemListView({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Container()
        : Padding(
            padding:
                const EdgeInsets.only(left: gridSpacing, right: gridSpacing, bottom: gridSpacing),
            child: GridView.count(
              physics: const ScrollPhysics(),
              childAspectRatio: 10 / 2,
              mainAxisSpacing: gridSpacing,
              crossAxisSpacing: gridSpacing,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                items.length,
                (index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(
                      items[index],
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
