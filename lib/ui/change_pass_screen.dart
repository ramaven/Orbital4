import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_register_auth/ui/widgets/original_button.dart';

class ChangePassScreen extends StatefulWidget {
  final ChangePassScreen authType;

  const ChangePassScreen({Key key, this.authType}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Stack(
            //   children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                          //color: Colors.orange[800],
                          ),
                    ),
                  ],
                )),
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter your email',
                          hintText: 'johndoe@gmail.com',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value) => value.isEmpty
                            ? 'You must enter a valid email'
                            : null,
                      ),
                      SizedBox(height: 20),
                      OriginalButton(
                        text: 'Reset Password',
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          // try {
                          auth.sendPasswordResetEmail(email: _email);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Password Reset'),
                                  content: Text(
                                      'Please check your email inbox for instructions to reset your password.'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              });
                          // } on PlatformException catch (e) {
                          //   print(e.toString());
                          //   showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: Text('ERROR'),
                          //           content: Text(
                          //               'There is no account with this email address.'),
                          //           actions: <Widget>[
                          //             TextButton(
                          //                 onPressed: () {
                          //                   Navigator.of(context).pop();
                          //                 },
                          //                 child: Text('OK'))
                          //           ],
                          //         );
                          //       });
                          // }
                        },
                      ),
                    ]))),
          ],
        ),
        // ],
        // ),
      ),
    );
  }
}
