import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/dialog.dart';
import 'package:tic_tac_toe/game_field.dart';

class Location {
  int row;
  int col;
  Location(this.row, this.col);
}

class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<String>> tileState = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  int step = 1;
  bool clickable = true;
  String player = 'o';
  String opponent = 'x';

  List<Location> possibleStep(List<List<String>> tiles) {
    List<Location> steps = [];
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (tiles[r][c] == '') steps.add(Location(r, c));
      }
    }
    return steps;
  }

  void reset() {
    setState(() {
      tileState = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      step = 1;
      clickable = true;
    });
  }

  void showResult(BuildContext context, String winner, String message) {
    showDialog(
        child: ResultDialog(
            winner: winner,
            msg: message,
            action: () {
              reset();
              Navigator.pop(context);
            }),
        context: context);
  }

  int evaluate() {
    // Checking for Rows for X or O victory.
    for (int row = 0; row < 3; row++) {
      if (tileState[row][0] == tileState[row][1] &&
          tileState[row][1] == tileState[row][2]) {
        if (tileState[row][0] == 'o')
          return -10;
        else if (tileState[row][0] == 'x') return 10;
      }
      if (tileState[0][row] == tileState[1][row] &&
          tileState[1][row] == tileState[2][row]) {
        if (tileState[0][row] == 'o')
          return -10;
        else if (tileState[0][row] == 'x') return 10;
      }
    }

    // Checking for Diagonals for X or O victory.
    if (tileState[0][0] == tileState[1][1] &&
        tileState[1][1] == tileState[2][2]) {
      if (tileState[0][0] == 'o')
        return -10;
      else if (tileState[0][0] == 'x') return 10;
    }

    if (tileState[0][2] == tileState[1][1] &&
        tileState[1][1] == tileState[2][0]) {
      if (tileState[0][2] == 'o')
        return -10;
      else if (tileState[0][2] == 'x') return 10;
    }

    if (possibleStep(tileState).length == 0)
      return 0;
    else
      return -1;
  }

  void aiTurn(BuildContext context) {
    int row = -1, col = -1;
    for (row = 0; row < 3; row++) {
      bool find = false;
      for (col = 0; col < 3; col++) {
        if (tileState[row][col] == '') {
          tileState[row][col] = opponent;
          if (evaluate() != -1) {
            find = true;
            break;
          } else {
            tileState[row][col] = '';
          }
        }
      }
      if (find) break;
    }
    if (row == 3 && col == 3) {
      for (row = 0; row < 3; row++) {
        bool find = false;
        for (col = 0; col < 3; col++) {
          if (tileState[row][col] == '') {
            tileState[row][col] = player;
            if (evaluate() != -1) {
              find = true;
              break;
            } else {
              tileState[row][col] = '';
            }
          }
        }
        if (find) break;
      }
    }
    if (row == 3 && col == 3) {
      List<Location> option = possibleStep(tileState);
      int index = Random().nextInt(option.length);
      row = option[index].row;
      col = option[index].col;
    }

    click(row, col, opponent);
    if (evaluate() != -1) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        if (evaluate() == 0)
          showResult(context, '', 'Draw!');
        else
          showResult(context, opponent, 'AI wins!');
      });
    }
  }

  void click(int row, int col, String type) {
    tileState[row][col] = type;
    if (evaluate() != -1)
      clickable = false;
    else
      clickable = !clickable;
    step++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxWidth > constraints.maxHeight
                          ? constraints.maxHeight * 0.7
                          : constraints.maxWidth * 0.7,
                    ),
                    child: GameField(
                      tileState: tileState,
                      onUpdated: (row, col) {
                        if (step > 9 || evaluate() != -1 || !clickable) return;
                        click(row, col, player);
                        if (evaluate() == -1) {
                          Future.delayed(Duration(seconds: 1)).then((_) {
                            aiTurn(context);
                          });
                        } else {
                          Future.delayed(Duration(seconds: 1)).then((_) {
                            if (evaluate() == 0)
                              showResult(context, '', 'Draw!');
                            else
                              showResult(context, player, 'You wins!');
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MaterialButton(
                      minWidth: double.infinity,
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text('Switch player'),
                      onPressed: clickable
                          ? () {
                              String c = opponent;
                              opponent = player;
                              player = c;
                              setState(() {
                                clickable = false;
                              });
                              Future.delayed(Duration(seconds: 1)).then((_) {
                                aiTurn(context);
                              });
                            }
                          : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0))),
                  MaterialButton(
                      minWidth: double.infinity,
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text('Reset'),
                      onPressed: reset,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0))),
                ],
              )),
        );
      },
    );
  }
}
