import 'package:flutter/material.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/screens/home_screen.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:
        Center(
          child: Center(
              child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 400, maxWidth: 400),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // Image border
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
                                await provider.register(_emailController.text);
                                     if (!context.mounted) return;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
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
