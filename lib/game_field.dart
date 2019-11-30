import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tile.dart';

class GameField extends StatelessWidget {
  final List<List<String>> tileState;
  final Function onUpdated;

  GameField(
      {Key key, this.tileState, this.onUpdated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: tileState
                .asMap()
                .map((int r, List<String> e) => MapEntry(
                    r,
                    SizedBox(
                      width: constraints.maxHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: e
                            .asMap()
                            .map((int c, String str) => MapEntry(
                                c,
                                Tile(
                                  type: str,
                                  onPressed: () {
                                    if (tileState[r][c] == '') {
                                      onUpdated(r, c);
                                    }
                                  },
                                )))
                            .values
                            .toList(),
                      ),
                    )))
                .values
                .toList());
      },
    );
  }
}
