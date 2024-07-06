import 'package:flutter/material.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';

class UserVerifiedPage extends StatelessWidget {
  final String verificationLink;

  const UserVerifiedPage({super.key, required this.verificationLink});

  Future<bool> verifyLink(String link) async {
    AuthProvider provider = AuthProvider();
    try {
      return await provider.verifyUser(link);
    } on Exception catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('EMAIL VERIFICATION', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: verifyLink(verificationLink),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data == true) {
              return buildVerifiedContent(context);
            } else {
              return Center(
                child: Column(children: [
                  const Text('Verification failed. Please try again.'),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[400]),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text("GO BACK TO LOGIN"),
                    ),
                ]),
              );
              
            }
          },
        ),
      ),
    );
  }

  Widget buildVerifiedContent(BuildContext context) {
    return Center(
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
                    borderRadius: BorderRadius.circular(10), // Image border
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
                  const Text("email successfully verified!"),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[400]),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text("GO BACK TO LOGIN"),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
