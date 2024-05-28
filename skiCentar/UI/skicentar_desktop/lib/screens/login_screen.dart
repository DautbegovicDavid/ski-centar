import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/material.dart';
import 'package:skicentar_desktop/providers/auth_provider.dart';
import 'package:skicentar_desktop/screens/lift_list_screen.dart';

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
      body: Stack(children: [
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
                                      labelText: "Username",
                                      suffixIcon: Icon(Icons.email)),
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
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () async {
                              AuthProvider provider = AuthProvider();
                              try {
                                await provider.login(_emailController.text,
                                    _passwordController.text);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LiftListScreen()));
                              } on Exception catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: Text("Error"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("OK"))
                                        ],
                                        content: Text(e.toString())));
                              }
                            },
                            child: const Text("LOGIN"))
                      ]),
                    ),
                  ))),
        ),
        if (false)
          const EasyLoader(
              image: AssetImage("assets/images/logo.png"),
              backgroundColor: Colors.red)
      ]),
    );
  }
}
