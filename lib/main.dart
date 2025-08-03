import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_app/providers/client_state_provider.dart';
import 'package:typeracer_app/providers/game_state_provider.dart';
import 'package:typeracer_app/screens/create_room_screen.dart';
import 'package:typeracer_app/screens/game_screen.dart';
import 'package:typeracer_app/screens/home_screen.dart';
import 'package:typeracer_app/screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameStateProvider()),
        ChangeNotifierProvider(create: (context) => ClientStateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        // home: HomeScreen(),
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/create-room': (context) => const CreateRoomScreen(),
          '/join-room': (context) => const JoinRoomScreen(),
          '/game-screen': (context) => const GameScreen(),
        },
      ),
    );
  }
}
