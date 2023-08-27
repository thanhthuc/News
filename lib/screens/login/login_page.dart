
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/state_management/bloc_login/login_bloc.dart';
import 'package:news/state_management/bloc_login/login_bloc_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LoginBloc loginBloc = LoginBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.of(context).pop();
              }),
          title: const Text('Login')
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Bookmark',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child:
               TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
              onChanged: loginBloc.usernameChange.add,
            ),
          )
            ,
          Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 10),
              child:
              StreamBuilder<String?>(
                  stream: loginBloc.username,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container();
                  }
              )
          )
            ,
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: loginBloc.passwordChange.add,
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 5),
                child:
                StreamBuilder<String?>(
                  stream: loginBloc.password,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container();
                  }
                )
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child:
                StreamBuilder<bool>(
                    stream: loginBloc.isValidToSubmit,
                    builder: (context, snapshot) {
                  return ElevatedButton(
                      onPressed: snapshot.data == false ? null : () {
                        if (kDebugMode) {
                          print("true");
                        }
                      },
                      child: const Text('Login')
                  );
                })
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
      ])
    ));
  }
}