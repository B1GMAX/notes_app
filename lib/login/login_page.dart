import 'package:flutter/material.dart';
import 'package:notes_app/login/login_bloc.dart';
import 'package:notes_app/note_list/note_list_page.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(20),
    );
    final textFieldErrorBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.redAccent),
      borderRadius: BorderRadius.circular(20),
    );
    return Provider<LoginBloc>(
      create: (context) => LoginBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return Scaffold(
          body: StreamBuilder<bool>(
            initialData: true,
            stream: context.read<LoginBloc>().isSignUpStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (email) => !EmailValidator.validate(email!)
                            ? 'Enter a valid email'
                            : null,
                        controller:
                            context.read<LoginBloc>().emailTextController,
                        decoration: InputDecoration(
                          hintText: 'Your email...',
                          enabledBorder: textFieldBorder,
                          errorBorder: textFieldErrorBorder,
                          focusedErrorBorder: textFieldErrorBorder,
                          focusedBorder: textFieldBorder,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller:
                            context.read<LoginBloc>().passwordController,
                        validator: (value) {
                          return value != null && value.length < 6
                              ? 'Enter min. 6 characters'
                              : null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Your password...',
                          enabledBorder: textFieldBorder,
                          errorBorder: textFieldErrorBorder,
                          focusedErrorBorder: textFieldErrorBorder,
                          focusedBorder: textFieldBorder,
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final isUserAlive = await (snapshot.data!
                                  ? context.read<LoginBloc>().logIn()
                                  : context.read<LoginBloc>().signUp());
                              if (isUserAlive && context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NoteListPage(),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            snapshot.data! ? 'Sign up' : 'Sign in',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!
                                ? 'Already have account?'
                                : 'Create account',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<LoginBloc>()
                                  .isSignUpSink
                                  .add(!snapshot.data!);
                            },
                            child: Text(
                              snapshot.data! ? 'Sign in' : 'Sign up',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                decorationColor: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
