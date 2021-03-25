



//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:roomandu/model/user_repository.dart';
//import 'package:roomandu/provider/currentuser.dart';
//
//class SignUpForm extends StatefulWidget {
//  @override
//  _SignUpFormState createState() => _SignUpFormState();
//}
//
//class _SignUpFormState extends State<SignUpForm> {
//  TextEditingController _fullNameController = TextEditingController();
//  TextEditingController _emailController = TextEditingController();
//  TextEditingController _passwordController = TextEditingController();
//  TextEditingController _confirmPasswordController = TextEditingController();
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  final FocusNode passwordField = FocusNode();
//  final FocusNode confirmpasswordField = FocusNode();
//  final FocusNode emailField = FocusNode();
//
//  bool _autoValidator = false;
//  bool _success;
//
//  String email, password, name, repassword;
//
//  void _signupUser(String email, String password, BuildContext context) async {
//    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//
//    try {
//      if (await _currentUser.signUpUser(email, password)) {
//        Navigator.pop(context);
//      }
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  @override
//  void initState() {
//    _emailController= TextEditingController();
//    _passwordController= TextEditingController();
//    _fullNameController= TextEditingController();
//    _confirmPasswordController= TextEditingController();
//    super.initState();
//  }
//
//  void _showSnackBar(String message) {
//    final SnackBar snackBar = SnackBar(
//      content: Text(message),
//      duration: Duration(seconds: 3),
//    );
//    _scaffoldKey.currentState.showSnackBar(snackBar);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final user= Provider.of<UserRepository>(context);
//    return SafeArea(
//      child: Scaffold(
//        key: _scaffoldKey,
//        resizeToAvoidBottomPadding: false,
//        backgroundColor: const Color(0xfff2f3f7),
//        body: Stack(
//          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height * 0.7,
//              width: MediaQuery.of(context).size.width,
//              child: Container(
//                decoration: const BoxDecoration(
//                  color: Colors.lightGreen,
//                  borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(70),
//                    bottomRight: Radius.circular(70),
//                  ),
//                ),
//              ),
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SingleChildScrollView(
//                  scrollDirection: Axis.vertical,
//                  child: Container(
//                    child: Form(
//                      key: _formKey,
//                      autovalidate: _autoValidator,
//                      // ignore: deprecated_member_use
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          ClipRRect(
//                            borderRadius: const BorderRadius.all(
//                              Radius.circular(20),
//                            ),
//                            child: SingleChildScrollView(
//                              scrollDirection: Axis.vertical,
//                              child: Container(
//                                height:
//                                    MediaQuery.of(context).size.height * 0.7,
//                                width: MediaQuery.of(context).size.width * 0.8,
//                                decoration: const BoxDecoration(
//                                  color: Colors.white,
//                                ),
//                                child: SingleChildScrollView(
//                                  scrollDirection: Axis.vertical,
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(
//                                            'Create Account',
//                                            style: TextStyle(
//                                              fontSize: MediaQuery.of(context)
//                                                      .size
//                                                      .height /
//                                                  30,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8),
//                                        child: TextFormField(
//                                          controller: _fullNameController,
//                                          keyboardType: TextInputType.name,
//                                          validator: (String value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter password';
//                                            }
//                                            return null;
//                                          },
//                                          onSaved: (String value) {
//                                            name = value;
//                                          },
//                                          decoration: const InputDecoration(
//                                              prefixIcon: Icon(
//                                                Icons.person_outline,
//                                                color: Colors.lightGreen,
//                                              ),
//                                              labelText: 'Full Name'),
//                                          onEditingComplete: () {
//                                            FocusScope.of(context)
//                                                .requestFocus(emailField);
//                                          },
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8),
//                                        child: TextFormField(
//                                          focusNode: emailField,
//                                          controller: _emailController,
//                                          keyboardType:
//                                              TextInputType.emailAddress,
//                                          onSaved: (String value) {
//                                            email = value;
//                                          },
//                                          validator: (String value) {
//                                            if (value.isEmpty) {
//                                              // The form is empty
//                                              return 'Enter email address';
//                                            }
//                                            // This is just a regular expression for email addresses
//                                            const String p =
//                                                '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
//                                                    '\\@' +
//                                                    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
//                                                    '(' +
//                                                    '\\.' +
//                                                    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
//                                                    ')+';
//                                            final RegExp regExp = RegExp(p);
//
//                                            if (regExp.hasMatch(value)) {
//                                              // So, the email is valid
//                                              return null;
//                                            }
//
//                                            // The pattern of the email didn't match the regex above.
//                                            return 'Email is not valid';
//                                          },
//                                          decoration: const InputDecoration(
//                                              prefixIcon: Icon(
//                                                Icons.email,
//                                                color: Colors.lightGreen,
//                                              ),
//                                              labelText: 'E-mail'),
//                                          onEditingComplete: () {
//                                            FocusScope.of(context)
//                                                .requestFocus(passwordField);
//                                          },
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8),
//                                        child: TextFormField(
//                                          focusNode: passwordField,
//                                          controller: _passwordController,
//                                          keyboardType: TextInputType.text,
//                                          obscureText: true,
//                                          onSaved: (String value) {
//                                            password = value;
//                                          },
//                                          validator: (String value) {
//                                            if (value.length > 5) {
//                                              return null;
//                                            }
//                                            return 'Password must be upto 6 characters';
//                                          },
//                                          decoration: const InputDecoration(
//                                            prefixIcon: Icon(
//                                              Icons.lock,
//                                              color: Colors.lightGreen,
//                                            ),
//                                            labelText: 'Password',
//                                          ),
//                                          onEditingComplete: () {
//                                            FocusScope.of(context).requestFocus(
//                                                confirmpasswordField);
//                                          },
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8),
//                                        child: TextFormField(
//                                          focusNode: confirmpasswordField,
//                                          controller:
//                                              _confirmPasswordController,
//                                          keyboardType: TextInputType.text,
//                                          obscureText: true,
//                                          validator: (String value) {
//                                            if (value.length > 5) {
//                                              return null;
//                                            }
//                                            return 'Password must be upto 6 characters';
//                                          },
//                                          onSaved: (String value) {
//                                            repassword = value;
//                                          },
//                                          decoration: const InputDecoration(
//                                            prefixIcon: Icon(
//                                              Icons.lock,
//                                              color: Colors.lightGreen,
//                                            ),
//                                            labelText: 'Confirm Password',
//                                          ),
//                                        ),
//                                      ),
//                                      const SizedBox(
//                                        height: 10.0,
//                                      ),
//                                      Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          Container(
//                                            height: 1.4 *
//                                                (MediaQuery.of(context)
//                                                        .size
//                                                        .height /
//                                                    20),
//                                            width: 5 *
//                                                (MediaQuery.of(context)
//                                                        .size
//                                                        .width /
//                                                    10),
//                                            margin: const EdgeInsets.only(
//                                                bottom: 20),
//                                            child: RaisedButton(
//                                              elevation: 5.0,
//                                              color: Colors.lightGreen,
//                                              shape: RoundedRectangleBorder(
//                                                borderRadius:
//                                                    BorderRadius.circular(30.0),
//                                              ),
//                                              onPressed: () async{
//                                                FormState form = _formKey.currentState;
//                                                if (form.validate()) {
//                                                  if (_passwordController.text == _confirmPasswordController.text) {
//                                                      if(!await user.signUp(email, password))
//                                                        return null;
//                                                  }
//                                                } else {
//                                                  _showSnackBar(
//                                                      "Password doesn't match.");
//                                                }
//                                              },
//                                              child: Text(
//                                                'Sign Up',
//                                                style: TextStyle(
//                                                  color: Colors.white,
//                                                  letterSpacing: 1.5,
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize:
//                                                      MediaQuery.of(context)
//                                                              .size
//                                                              .height /
//                                                          40,
//                                                ),
//                                              ),
//                                            ),
//                                          )
//                                        ],
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
