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
                        controller:
                            context.read<LoginBloc>().emailTextController,
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller:
                            context.read<LoginBloc>().passwordController,
                      ),
                      const SizedBox(height: 22),
                      ElevatedButton(
                        onPressed: () {
                          snapshot.data!
                              ? context.read<LoginBloc>().logIn()
                              : context.read<LoginBloc>().signIn();
                        },
                        child: Text(snapshot.data! ? 'Sign up' : 'Sign in'),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(snapshot.data!
                              ? 'Already have account?'
                              : 'Create account'),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().changeRegisterType(
                                  snapshot.data! ? false : true);
                            },
                            child: Text(snapshot.data! ? 'Sign in' : 'Sign up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
