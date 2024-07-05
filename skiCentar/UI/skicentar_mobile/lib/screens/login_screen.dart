import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/layouts/master_screen.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/register_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

    @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // doubl echekc da nesto ne kehne

  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
     userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME TO SKI CENTER',
            style: TextStyle(color: Colors.white)),
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
                              minimumSize:
                                  MaterialStateProperty.all(Size(200, 40))),
                          onPressed: () async {
                            AuthProvider provider = AuthProvider();
                            try {
                              await provider.login(_emailController.text,
                                  _passwordController.text);
                              await _fetchUser();
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
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

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userProvider.getDetails();
      userProvider.setUser(fetchedUser);
    } catch (e) {
      print('Failed to load user: $e');
    }
  }
}
