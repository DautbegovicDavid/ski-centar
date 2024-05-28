import 'package:flutter/material.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';

class UserVerifiedPage extends StatelessWidget {
  const UserVerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('EMAIL VERIFIED', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Center(
            child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  minWidth: 400,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(100), // Image radius
                              child: Image.asset(
                                "assets/images/email-verified.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text("Registration complete,"),
                          const Text("email succesfuly verified !"),
                          const Spacer(),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[400]),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () async {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              },
                              child: const Text("GO BACK TO LOGIN")),
                          const Spacer(),

                        ]),
                  ),
                ))),
      ),
    );
  }
}
