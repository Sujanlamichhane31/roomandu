import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roomandu/provider/user_repository.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool signInForm;
  @override
  void initState() {
    super.initState();
    signInForm = true;
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return WillPopScope(
      onWillPop: () async {
        if (!signInForm) {
          setState(() {
            signInForm = true;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                 SizedBox(
                  height: kToolbarHeight, // ignore: prefer_const_literals_to_create_immutables
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  width: 80.0,
                  height: 80.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                user.status == Status.Authenticated
                ? Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.white,)):
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text("Continue with Google"),
                      onPressed: () async{
                        if(!await user.signInWithGoogle())
                          showMessage();
                      },
                    ),
                SizedBox(height: 20.0,),
                OutlineButton(
                    textColor: Colors.black,
                    child: signInForm
                    ? Text("Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    ): Icon(Icons.arrow_back),
                    onPressed: (){
                      setState(() {
                        signInForm=!signInForm;
                      });
                    },
                color: Colors.white,
                borderSide: BorderSide(color: Colors.white),
                highlightColor: Colors.white,
                )
              ],
            ),
          )
        ),
      ),
    );
  }
  void showMessage({String message = 'Something is wrong'}) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

class LoginForm extends StatefulWidget {
  final Function showError;
  
  // ignore: sort_constructors_first
  const LoginForm({Key key, this.showError}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode passwordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _password;
  
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Login',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.display1,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              validator: (String val) {
                // ignore: always_put_control_body_on_new_line
                if (val.isEmpty) return 'Email is required';
              return val;
                },
              controller: _email,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'email address'),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordField);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              validator: (String val) {
                // ignore: always_put_control_body_on_new_line
                if (val.isEmpty) return 'password is required';
                return val;
  
              },
              obscureText: true,
              controller: _password,
              focusNode: passwordField,
              decoration: const InputDecoration(labelText: 'password'),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: user.status == Status.Authenticating ?
              const Center(child: CircularProgressIndicator()) : RaisedButton(
                textColor: Colors.white,
                child: const Text('Login'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if(!await user.signIn(_email.text, _password.text))
                      widget.showError();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final Function showError;
  
  // ignore: sort_constructors_first
  const SignupForm({Key key, this.showError}) : super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FocusNode passwordField = FocusNode();
  final FocusNode confirmPasswordField = FocusNode();
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Sign up',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.display1,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _email,
              validator: (String val) {
                // ignore: always_put_control_body_on_new_line
                if (val.isEmpty) return 'Email is required';
                return val;
  
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'email address'),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordField);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              validator: (String val) {
                // ignore: always_put_control_body_on_new_line
                if (val.isEmpty) return 'Password is required';
                return val;
  
              },
              obscureText: true,
              controller: _password,
              focusNode: passwordField,
              decoration: const InputDecoration(labelText: 'password'),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(confirmPasswordField),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              obscureText: true,
              controller: _confirmPassword,
              validator: (String val) {
                // ignore: always_put_control_body_on_new_line
                if (val.isEmpty) return 'Confirm password is required';
                return val;
  
              },
              focusNode: confirmPasswordField,
              decoration: const InputDecoration(labelText: 'confirm password'),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: user.status == Status.Authenticating ?
              const Center(child: CircularProgressIndicator()) : RaisedButton(
                textColor: Colors.white,
                child: const Text('Create Account'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (_confirmPassword.text == _password.text) {
                      if(!await user.signUp(_email.text, _password.text))
                        widget.showError();
                    }
                    else
                      widget.showError('Passsword and confirm password does not match');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:roomandu/auth/signinPage.dart';
//import 'package:roomandu/model/user_repository.dart';
//
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//  bool signInForm;
//
//  @override
//  void initState() {
//    super.initState();
//    signInForm = true;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final user = Provider.of<UserRepository>(context);
//    return WillPopScope(
//      onWillPop: () async {
//        if (!signInForm) {
//          setState(() {
//            signInForm = true;
//          });
//          return false;
//        } else {
//          return true;
//        }
//      },
//      child: Scaffold(
//        key: _key,
//        backgroundColor: Colors.lightGreen,
//        body: SingleChildScrollView(
//          padding: EdgeInsets.all(16.0),
//          child: SizedBox(
//            width: double.infinity,
//            child: Column(
//              children: [
//                SizedBox(
//                  height: kToolbarHeight,
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 70),
//                  child: Text(
//                    'Roomandu',
//                    style: TextStyle(
//                      fontSize: MediaQuery.of(context).size.height / 25,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 30.0,
//                ),
//                user.status == Status.Authenticated
//                    ? Center(
//                        child: CircularProgressIndicator(
//                          backgroundColor: Colors.white,
//                        ),
//                      )
//                    : GestureDetector(
//                        onTap: () async {
//                          if (!await user.signInWithGoogle())
//                            _key.currentState.showSnackBar(SnackBar(
//                              content: Text("Something is Wrong"),
//                            ));
//                        },
//                        child: Container(
//                          height: 60,
//                          width: 60,
//                          decoration: const BoxDecoration(
//                            shape: BoxShape.circle,
//                            color: Colors.lightGreen,
//// ignore: always_specify_types
//                            boxShadow: [
//                              BoxShadow(
//                                  color: Colors.black26,
//                                  offset: Offset(0, 2),
//                                  blurRadius: 6.0)
//                            ],
//                          ),
//                          child: const Icon(
//                            FontAwesomeIcons.google,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//
//                SizedBox(height: 30.0,),
//                AnimatedSwitcher(
//                    child: signInForm ? LoginForm():SignUpForm(),
//                    duration: Duration(milliseconds: 200),
//                ),
//                const SizedBox(height: 20.0,),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.only(top: 40),
//                      child: signInForm ?FlatButton(
//                        onPressed: () {
//                          Navigator.pushNamed(context, '/signinpage');
//                        },
//                        child: RichText(
//                          // ignore: always_specify_types
//                          text: TextSpan(children: [
//                            TextSpan(
//                              text: 'Dont have an account? ',
//                              style: TextStyle(
//                                color: Colors.black,
//                                fontSize:
//                                MediaQuery.of(context).size.height / 40,
//                                fontWeight: FontWeight.w400,
//                              ),
//                            ),
//                            TextSpan(
//                              text: 'Sign Up',
//                              style: TextStyle(
//                                color: Colors.lightGreen,
//                                fontSize:
//                                MediaQuery.of(context).size.height / 40,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            )
//                          ]),
//                        ),
//                      ): OutlineButton(
//                        color: Colors.white,
//                          borderSide: BorderSide(color: Colors.white),
//                          highlightColor: Colors.white,
//                          textColor: Colors.black,
//                          onPressed: (){
//                            setState(() {
//                              signInForm= !signInForm;
//                            });
//                          }),
//                    ),
//                  ],
//                ),
//
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  void showMessage({String message = "Something is wrong"}){
//    _key.currentState.showSnackBar(SnackBar(
//        content: Text(message))
//    );
//  }
//}
//
//class LoginForm extends StatefulWidget {
//  @override
//  _LoginFormState createState() => _LoginFormState();
//}
//
//class _LoginFormState extends State<LoginForm> {
//  final FocusNode passwordField = FocusNode();
//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//  final _key = GlobalKey<ScaffoldState>();
//  TextEditingController email;
//  TextEditingController password;
//
//  void showMessage({String message = "Something is wrong"}) {
//    _key.currentState.showSnackBar(SnackBar(
//      content: Text(message),
//    ));
//  }
//
//  @override
//  void initState() {
//    email = TextEditingController();
//    password = TextEditingController();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final user = Provider.of<UserRepository>(context);
//    return SafeArea(
//      child: Scaffold(
//        resizeToAvoidBottomPadding: false,
//        backgroundColor: const Color(0xfff2f3f7),
//        body: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: Stack(
//            children: <Widget>[
//              Container(
//                height: MediaQuery.of(context).size.height * 0.7,
//                width: MediaQuery.of(context).size.width,
//                child: Container(
//                  decoration: const BoxDecoration(
//                    color: Colors.lightGreen,
//                    borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(70),
//                      bottomRight: Radius.circular(70),
//                    ),
//                  ),
//                ),
//              ),
//              Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      ClipRRect(
//                        borderRadius: const BorderRadius.all(
//                          Radius.circular(20),
//                        ),
//                        child: Container(
//                          height: MediaQuery.of(context).size.height * 0.6,
//                          width: MediaQuery.of(context).size.width * 0.8,
//                          decoration: const BoxDecoration(
//                            color: Colors.white,
//                          ),
//                          child: SingleChildScrollView(
//                            scrollDirection: Axis.vertical,
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      'Login',
//                                      style: TextStyle(
//                                        fontWeight: FontWeight.w500,
//                                        fontSize:
//                                            MediaQuery.of(context).size.height /
//                                                30,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.all(8),
//                                  child: TextFormField(
//                                    validator: (val) {
//                                      if (val.isEmpty)
//                                        return "Email is Required";
//                                      return val;
//                                    },
//                                    controller: email,
//                                    textInputAction: TextInputAction.next,
//                                    keyboardType: TextInputType.emailAddress,
////                                    onChanged: (String value) {
////                                      setState(() {
////                                        email = value;
////                                      });
////                                    },
//                                    decoration: const InputDecoration(
//                                        prefixIcon: Icon(
//                                          Icons.email,
//                                          color: Colors.lightGreen,
//                                        ),
//                                        labelText: 'E-mail'),
//                                    onEditingComplete: () {
//                                      FocusScope.of(context)
//                                          .requestFocus(passwordField);
//                                    },
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.all(8),
//                                  child: TextFormField(
//                                    validator: (val) {
//                                      if (val.isEmpty)
//                                        return "password is required";
//                                      return val;
//                                    },
//                                    controller: password,
//                                    focusNode: passwordField,
//                                    keyboardType: TextInputType.text,
//                                    obscureText: true,
////                                    onChanged: (String value) {
////                                      setState(() {
////                                        password = value;
////                                      });
////                                    },
//                                    decoration: const InputDecoration(
//                                      prefixIcon: Icon(
//                                        Icons.lock,
//                                        color: Colors.lightGreen,
//                                      ),
//                                      labelText: 'Password',
//                                    ),
//                                  ),
//                                ),
////                                Row(
////                                  mainAxisAlignment: MainAxisAlignment.start,
////                                  crossAxisAlignment: CrossAxisAlignment.start,
////                                  children: <Widget>[
////                                    FlatButton(
////                                      onPressed: () {},
////                                      child: const Text('Forgot Password'),
////                                    ),
////                                  ],
////                                ),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Container(
//                                      height: 1.4 *
//                                          (MediaQuery.of(context).size.height /
//                                              20),
//                                      width: 5 *
//                                          (MediaQuery.of(context).size.width /
//                                              10),
//                                      margin: const EdgeInsets.only(bottom: 20),
//                                      child: RaisedButton(
//                                        elevation: 5.0,
//                                        color: Colors.lightGreen,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                              BorderRadius.circular(30.0),
//                                        ),
//                                        onPressed: () async {
//                                          if (_formkey.currentState
//                                              .validate()) {
//                                            if (!await user.signIn(
//                                                email.text, password.text))
//                                              showMessage();
//                                          }
//                                        },
//                                        child: Text(
//                                          'Login',
//                                          style: TextStyle(
//                                            color: Colors.white,
//                                            letterSpacing: 1.5,
//                                            fontSize: MediaQuery.of(context)
//                                                    .size
//                                                    .height /
//                                                40,
//                                          ),
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
////                                Row(
////                                  mainAxisAlignment: MainAxisAlignment.center,
////                                  children: <Widget>[
////                                    Container(
////                                      margin: const EdgeInsets.only(bottom: 20),
////                                      child: const Text(
////                                        '- OR -',
////                                        style: TextStyle(
////                                          fontWeight: FontWeight.w400,
////                                        ),
////                                      ),
////                                    )
////                                  ],
////                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
