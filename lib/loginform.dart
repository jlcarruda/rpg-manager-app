import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'models/response.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void getEmailText() {
    setState(() {
     _email = emailController.text;
    });
  }

  void getPasswordText() {
    setState(() {
      _password = passwordController.text;
    });
  }

  void sendSigninRequest() async {
    getEmailText();
    getPasswordText();
    if (_email == '' || _password == '') {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(Uri.parse('http://172.30.122.23:8081/users/signin'));

    if (response.statusCode == 200) {
      print(Response.fromJson(jsonDecode(response.body)));
    } else {
      throw Exception('Failed');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
        child: Column(
          children:  <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.email,
                  color: Color(0xFFFF4891),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade100 )),
                labelText: "Email",
                enabledBorder: InputBorder.none,
                labelStyle: const TextStyle(color: Colors.grey)),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.vpn_key,
                    color: Color(0xFFFF4891),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade100)),
                  labelText: "Password",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
          child: const Text(
            "FORGOT PASSWORD?",
            style:
                TextStyle(color: Color(0xFFFF4891), fontSize: 11),
          )
        )
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              child: Container(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.amber,
                    onTap: sendSigninRequest,
                    child: const Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFFB226B2),
                          Color(0xFFFF4891)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
            ),
            // FloatingActionButton(
            //   onPressed: () {},
            //   mini: true,
            //   elevation: 0,
            //   child: const Image(
            //     image: AssetImage("assets/facebook2.png"),
            //   ),
            // ),
            // FloatingActionButton(
            //   onPressed: () {},
            //   mini: true,
            //   elevation: 0,
            //   child: const Image(
            //     image: AssetImage("assets/twitter.png"),
            //   ),
            // ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            "DON'T HAVE AN ACCOUNT ? ",
            style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          Text(
            " SIGN UP",
            style: TextStyle(
                fontSize: 11,
                color: Color(0xFFFF4891),
                fontWeight: FontWeight.w700),
          )
        ],
      )
    ]);
  }
}
