import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeBoard(),
    );
  }
}

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late List<String> board;
  late String currentPlayer;
  late String winner;

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    setState(() {
      board = List.generate(9, (index) => '');
      currentPlayer = 'X';
      winner = "none";
    });
  }

  void playMove(int index) {
    if (board[index] == '' && winner == "none") {
      setState(() {
        board[index] = currentPlayer;
        checkWinner();
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });
    }
  }

  void checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] != '' &&
          board[i * 3] == board[i * 3 + 1] &&
          board[i * 3 + 1] == board[i * 3 + 2]) {
        setState(() {
          winner = board[i * 3];
        });
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        setState(() {
          winner = board[i];
        });
        return;
      }
    }

    // Check diagonals
    if (board[0] != '' && board[0] == board[4] && board[4] == board[8]) {
      setState(() {
        winner = board[0];
      });
      return;
    }
    if (board[2] != '' && board[2] == board[4] && board[4] == board[6]) {
      setState(() {
        winner = board[2];
      });
      return;
    }

    // Check for draw
    if (!board.contains('') && winner == "none") {
      setState(() {
        winner = 'Draw';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner != "none" ? '$winner Wins!' : 'Current Player: $currentPlayer',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  playMove(index);
                },
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              initializeBoard();
            },
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
