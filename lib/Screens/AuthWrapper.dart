import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Home.dart' ; // Asegúrate de tener esta pantalla creada
import 'LoginScreen.dart';

class AuthWrapper extends StatelessWidget{

   @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>
    ( stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting)
        {
            return Scaffold(
                body: Center(child: CircularProgressIndicator(),),
            );
        }

        if(snapshot.hasData){
            return ScreensButtons();
        }
        else
        {
            return LoginScreen();
        }
      }

    );

  } 
}