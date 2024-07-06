import 'package:flutter/material.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Center(
            child: Container(
                constraints:
                    const BoxConstraints(maxHeight: 400, maxWidth: 400),
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
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    labelText: "Email ",
                                    suffixIcon: Icon(Icons.email)),
                              ),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(Icons.password)),
                              ),
                            ],
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[400]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () async {
                            AuthProvider provider = AuthProvider();
                            try {
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
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
                                        content: const Text(
                                            "Email and password are required")));
                                return;
                              }
                              await provider.register(_emailController.text,
                                  _passwordController.text);
                              if (!context.mounted) return;
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: const Text("SUCCESS"),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.of(
                                                    context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                    (Route<dynamic> route) =>
                                                        false),
                                            child: const Text("OK"))
                                      ],
                                      content: const Text(
                                          "Check your inbox. Pay attention to spam folder.")));
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
                          child: const Text("CREATE ACCOUNT"))
                    ]),
                  ),
                ))),
      ),
    );
  }
}
