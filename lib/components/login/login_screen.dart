import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_action.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginWidget());
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginAction>(
      create: (_) => LoginAction(),
      child: _LoginWidget(),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  _LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final action = context.read<LoginAction>();
    final connecting =
        context.select<LoginAction, bool>((value) => value.state.connecting);
    // final password = context.select<LoginAction, String>((value) => value.state.password);

    return Align(
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 320.0, maxHeight: 280.0),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // テキスト入力のラベルを設定
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (value) => action.updateEmail(value),
                    autofillHints: [AutofillHints.email],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    // パスワードが見えないようにする
                    obscureText: true,
                    onChanged: (value) => action.updatePassword(value),
                    autofillHints: [AutofillHints.password],
                    onFieldSubmitted: (v) async {
                      await action.login();
                    },
                  ),
                  const SizedBox(height: 50),
                  if (connecting)
                    CircularProgressIndicator()
                  else
                    SizedBox(
                      width: 280,
                      height: 30,
                      child: ElevatedButton(
                        child: Text('LOG IN'),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.red,
                          // onPrimary: Colors.black,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () async {
                          await action.login();
                        },
                      ),
                    )
                ],
              ),
            )),
      ),
    );
  }
}
