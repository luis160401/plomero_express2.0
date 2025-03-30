import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registro exitoso")));
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al registrar usuario")));
    }
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inicio de sesión exitoso")));
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No se pudo completar el inicio de sesión")));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // El usuario canceló la selección

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inicio de sesión con Google exitoso")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al iniciar sesión con Google")));
    }
  }

  Future<void> signInWithFacebook() async {
    // FirebaseAuth.instance.signInWithCredential() debe ser configurado con Facebook Login
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inicio de sesión con Facebook no implementado aún")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log in")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Correo Electrónico o Usuario"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 10),

            // Botón de inicio de sesión con email y contraseña
            ElevatedButton(onPressed: login, child: Text('Iniciar sesión')),

            SizedBox(height: 10),

            // Botón para registrarse con email y contraseña
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Crear Cuenta Nueva'),
            ),

            SizedBox(height: 20),
            Divider(),

            // Botón para iniciar sesión con Google
            ElevatedButton.icon(
              onPressed: signInWithGoogle,
              icon: Icon(Icons.login, color: Colors.white),
              label: Text("Iniciar sesión con Google"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),

            SizedBox(height: 10),

            // Botón para iniciar sesión con Facebook
            ElevatedButton.icon(
              onPressed: signInWithFacebook,
              icon: Icon(Icons.facebook, color: Colors.white),
              label: Text("Iniciar sesión con Facebook"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
