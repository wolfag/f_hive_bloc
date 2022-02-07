import 'package:f_hive_bloc/home/bloc/home_bloc.dart';
import 'package:f_hive_bloc/services/authentication.dart';
import 'package:f_hive_bloc/services/todo.dart';
import 'package:f_hive_bloc/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Todo app'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TodosPage(
                    username: state.username,
                  ),
                ),
              );
            }
          },
          builder: (context, snapshot) {
            if (snapshot is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    controller: usernameField,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordField,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(
                        LoginEvent(usernameField.text, passwordField.text),
                      );
                    },
                    child: const Text('LOGIN'),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
