// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext contet, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildListSeparatedAtEnds(items);
      } else {
        return EmptyContent(
          title: 'Add something new',
          message: 'Seriously, there\'s nothing here',
        );
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Cannot load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  /// Will not add separation lines at start and end
  /// TODO: decide on which to use
  // Widget _buildList(List<T> items) {
  //   // A ListView factory contructor that can return a large number of items
  //   return ListView.separated(
  //     separatorBuilder: (context, index) => Divider(height: 0.5),
  //     itemBuilder: (context, index) => itemBuilder(context, items[index]),
  //     itemCount: items.length,
  //   );
  // }

  /// Will add separation lines at start and end
  Widget _buildListSeparatedAtEnds(List<T> items) {
    // A ListView factory contructor that can return a large number of items
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
