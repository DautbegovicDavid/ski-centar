import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/layouts/master_screen.dart';
import 'package:skicentar_mobile/providers/auth_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserProvider userProvider;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();

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
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: Image.asset("assets/images/logo.png",
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(
                            height: 210,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    suffixIcon: Icon(Icons.email),
                                  ),
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
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: "Password",
                                      suffixIcon: Icon(Icons.password)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    _isButtonEnabled
                                        ? Colors.blue[400]
                                        : Colors.grey),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(200, 40))),
                            onPressed: _isButtonEnabled
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      AuthProvider provider = AuthProvider();
                                      try {
                                        await provider.login(
                                            _emailController.text,
                                            _passwordController.text);
                                        await _fetchUser();
                                        if (!context.mounted) return;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MasterScreen()));
                                      } on Exception catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text("Error"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text("OK"))
                                                  ],
                                                  content: Text(e.toString()),
                                                ));
                                      }
                                    }
                                  }
                                : null,
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
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
      throw Exception('Failed to load user: $e');
    }
  }
}
