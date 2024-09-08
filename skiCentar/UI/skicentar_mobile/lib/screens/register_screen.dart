import 'package:flutter/material.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _isValidEmail(_emailController.text);
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

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
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  labelText: "Email ",
                                  suffixIcon: Icon(Icons.email)),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!_isValidEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: Icon(Icons.password)),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _isButtonEnabled
                                ? Colors.blue[400]
                                : Colors
                                    .grey
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: _isButtonEnabled
                            ? () async {
                                AuthProvider provider = AuthProvider();
                                try {
                                  await provider.register(_emailController.text,
                                      _passwordController.text);
                                  if (!context.mounted) return;
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("SUCCESS"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
                                                  (Route<dynamic> route) =>
                                                      false),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                      content: const Text(
                                          "Check your inbox. Pay attention to spam folder."),
                                    ),
                                  );
                                } on Exception catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: const Text("CREATE ACCOUNT"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
