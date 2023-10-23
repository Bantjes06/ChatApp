import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat/screens/auth.dart';
import 'package:flutter/material.dart';

void main() async {
// Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
// Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: StreamBuilder(
// Stream to listen to authentication state changes
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
// Show splash screen while connection state is waiting
            if(snapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
// If user is authenticated, show the chat screen
            if (snapshot.hasData) {
              return const ChatScreen();
            }
// If user is not authenticated, show the authentication screen
            return const AuthScreen();
          },
        ));
  }
}
