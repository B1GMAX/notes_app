import 'package:flutter/material.dart';
import 'package:notes_app/login/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: context.read<LoginBloc>().emailTextController,
                      decoration: InputDecoration(
                        hintText: 'Your email...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: context.read<LoginBloc>().passwordController,
                      decoration: InputDecoration(
                        hintText: 'Your password...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          snapshot.data!
                              ? context.read<LoginBloc>().logIn()
                              : context.read<LoginBloc>().signIn();
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
                            context.read<LoginBloc>().changeSignType(
                                !snapshot.data!);
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
              );
            },
          ),
        );
      },
    );
  }
}
