import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skicentar_mobile/layouts/master_screen.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/screens/register_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME TO SKI CENTER',
            style: TextStyle(color: Colors.white)),
        surfaceTintColor: Colors.red,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Center(
            child: Container(
                constraints:
                    const BoxConstraints(maxHeight: 440, maxWidth: 400),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset("assets/images/logo.png",
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          height: 210,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    labelText: "Username",
                                    suffixIcon: Icon(Icons.email),
                                  ),
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(Icons.password)),
                              )
                            ],
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[400]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                               minimumSize: MaterialStateProperty.all(Size(200,40))
                                  ),
                          onPressed: () async {
                            AuthProvider provider = AuthProvider();
                            try {
                              await provider.login(_emailController.text,
                                  _passwordController.text);
                              if (!context.mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MasterScreen()));
                            } on Exception catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("OK"))
                                      ],
                                      content: Text(e.toString())));
                            }
                          },
                          child: const Text("LOGIN")),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          text: 'New to platform? ',
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Create account',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the click event here
                                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                                  print('Create account clicked');
                                  // Navigate to the create account screen or perform any action
                                },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ))),
      ),
    );
  }
}
