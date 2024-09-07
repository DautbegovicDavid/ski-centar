import 'package:flutter/material.dart';
import 'package:skicentar_desktop/providers/auth_provider.dart';
import 'package:skicentar_desktop/screens/lift_list_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _isValidEmail(_emailController.text) &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login(BuildContext context) async {
    AuthProvider provider = AuthProvider();
    try {
      await provider.login(_emailController.text, _passwordController.text);
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LiftListScreen(),
        ),
      );
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WELCOME TO SKI CENTER',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Stack(
        children: [
          Center(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Username",
                                    suffixIcon: Icon(Icons.email),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(Icons.password),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) {
                                    if (_isButtonEnabled) {
                                      _login(context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        FilledButton(
                          onPressed: _isButtonEnabled
                              ? () => _login(context)
                              : null,
                          child: const Text("LOGIN"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
