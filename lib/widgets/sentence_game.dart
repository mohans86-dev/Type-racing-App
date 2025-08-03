import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_app/providers/game_state_provider.dart';
import 'package:typeracer_app/utils/socket_client.dart';
import 'package:typeracer_app/utils/socket_methods.dart';
import 'package:typeracer_app/widgets/score_board.dart';

class SentenceGame extends StatefulWidget {
  const SentenceGame({Key? key}) : super(key: key);

  @override
  State<SentenceGame> createState() => _SentenceGameState();
}

class _SentenceGameState extends State<SentenceGame> {
  var playerMe;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGame(context);
  }

  void findPlayerMe(GameStateProvider game) {
    playerMe = game.gameState['players'].firstWhere(
      (player) => player['socketID'] == SocketClient.instance.socket!.id,
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    findPlayerMe(game);

    if (playerMe == null) {
      return const SizedBox(); // or show a loading indicator or message
    }

    final words = game.gameState['words'];
    final currentIndex = playerMe['currentWordIndex'];

    if (words.isEmpty) {
      return const Center(
        child: Text(
          'Waiting for words...',
          style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
        ),
      );
    }

    if (currentIndex >= words.length) {
      return const Scoreboard();
    }

    // Create the styled text spans for typed, current, and upcoming words
    List<TextSpan> textSpans = [];

    // Typed words - green and normal weight
    if (currentIndex > 0) {
      textSpans.add(
        TextSpan(
          text: words.sublist(0, currentIndex).join(' ') + ' ',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Current word - underline and bold
    textSpans.add(
      TextSpan(
        text: words[currentIndex] + ' ',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );

    // Remaining words - grey color and lighter weight
    if (currentIndex + 1 < words.length) {
      textSpans.add(
        TextSpan(
          text: words.sublist(currentIndex + 1).join(' '),
          style: TextStyle(
            fontSize: 22,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: RichText(text: TextSpan(children: textSpans)),
      ),
    );
  }
}
