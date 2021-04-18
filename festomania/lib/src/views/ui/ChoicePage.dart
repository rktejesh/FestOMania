import 'dart:async';
import 'dart:ui';
import 'package:festomania/src/views/ui/LoginPage.dart';
import 'package:festomania/src/views/ui/SignupPage.dart';
import 'package:festomania/src/views/utils/Logo.dart';
import 'package:festomania/src/views/utils/database.dart';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';

//Hides keyboard since no input is required
void hideKeyboard(BuildContext context) {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  FocusScope.of(context).requestFocus(FocusNode());
}

class ChoicePage extends StatefulWidget {
  @override
  _ChoicePageState createState() => _ChoicePageState();
}

bool loading = false;
class _ChoicePageState extends State<ChoicePage> {
  String errorText = "";
  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
              child: AlertDialog(
                content: Text(
                    errorText),
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6));
        });
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential user;
  //Authentication for github
  Future<void> signInWithGitHub() async {
    try {
      setState(() {
        loading = true;
      });
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: "ce0106e536d0adadd613",
          clientSecret: "c52567186408a8a28d3533789a1d24bc4e4efb24",
          redirectUrl:
          'https://supernova-433f4.firebaseapp.com/__/auth/handler');
      final result = await gitHubSignIn.signIn(context);
      final AuthCredential githubAuthCredential = GithubAuthProvider.credential(result.token);
      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
      await DatabaseService(uid: _firebaseAuth.currentUser.uid).updateUserData(_firebaseAuth.currentUser.displayName, _firebaseAuth.currentUser.email,_firebaseAuth.currentUser.uid,null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        setState(() {
          loading = false;
          errorText="An account already exists with this email.";
          _showDialog();
        });
      }
      else if (e.code == 'invalid-credential') {
        loading = false;
        errorText="The username or password is incorrect.";
        _showDialog();
      }
    } catch (e) {
      loading = false;
      errorText="Error could not sign in. Please try again.";
      _showDialog();
    }
  }

  //Authentication for google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
    await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      setState(() {
        loading = true;
      });
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        setState(() {
          loading = true;
        });
        await FirebaseAuth.instance.signInWithCredential(credential);
        await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).updateUserData(FirebaseAuth.instance.currentUser.displayName, FirebaseAuth.instance.currentUser.email,_firebaseAuth.currentUser.uid,null);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          setState(() {
            loading = false;
            errorText="An account already exists with this email.";
            _showDialog();
          });
        }
        else if (e.code == 'invalid-credential') {
          loading = false;
          errorText="The username or password is incorrect.";
          _showDialog();
        }
      } catch (e) {
        loading = false;
        errorText="Error could not sign in. Please try again.";
        _showDialog();
      }
    }
    return user;
  }

  //Authentication for unsigned users
  Future<void> _signInAnonymously() async {
    try {
      setState(() {
        loading = true;
      });
      await _firebaseAuth.signInAnonymously();
      await DatabaseService(uid: _firebaseAuth.currentUser.uid).updateUserData(_firebaseAuth.currentUser.displayName, _firebaseAuth.currentUser.email,_firebaseAuth.currentUser.uid,null);
    } catch (e) {
      setState(() {
        loading = false;
        errorText="Error could not sign in. Please try again.";
        _showDialog();
      });
    }
  }
  //Authentication for Facebook user
  FacebookLogin _facebookLogin = FacebookLogin();
  Future _handleLogin() async {
    FacebookLoginResult _result = await _facebookLogin.logIn(['email']);
    switch(_result.status)
    {
      case FacebookLoginStatus.cancelledByUser:
        loading = false;
        break;
      case FacebookLoginStatus.error:
        loading = false;
        errorText="Error could not sign in. Please try again.";
        _showDialog();
        break;
      case FacebookLoginStatus.loggedIn:
        loading = false;
        await (_loginWithFacebook(_result));
        break;
    }
  }

  Future _loginWithFacebook(FacebookLoginResult _result) async {
    try {
      setState(() {
        loading = true;
      });
      FacebookAccessToken _accessToken = _result.accessToken;
      AuthCredential _credential =
      FacebookAuthProvider.credential(_accessToken.token);
      await _firebaseAuth.signInWithCredential(_credential);
      await DatabaseService(uid: _firebaseAuth.currentUser.uid).updateUserData(_firebaseAuth.currentUser.displayName, _firebaseAuth.currentUser.email,_firebaseAuth.currentUser.uid,null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        setState(() {
          loading = false;
          errorText="An account already exists with this email.";
          _showDialog();
        });
      }
      else if (e.code == 'invalid-credential') {
        loading = false;
        errorText="The username or password is incorrect.";
        _showDialog();
      }
    } catch (e) {
      loading = false;
      errorText="Error could not sign in. Please try again.";
      _showDialog();
    }
  }
  //Authentication for Facebook user ends here
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: const Color(0xff5c6bc0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30),
            child: AppLogo1(),
          ),
          Padding(
            padding: EdgeInsets.only( left: 30, right: 30, top: 60, bottom: 120),
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 10,right: 45,left: 45),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(149, 157, 165, 0.1),
                                offset: Offset(0, 0),
                                blurRadius: 24,
                              )
                            ]
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),));
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(left: 45, right: 45, top: 3,bottom: 3)
                            ),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Alegreya',
                              fontSize: 28,
                              color: const Color(0xff1c69f0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 25,right: 45,left: 45),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(149, 157, 165, 0.1),
                                offset: Offset(0, 0),
                                blurRadius: 16,
                              )
                            ]
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupPage(),));
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(left: 45, right: 45, top: 3,bottom: 3)
                            ),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontFamily: 'Alegreya',
                              fontSize: 28,
                              color: const Color(0xff1c69f0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        fontSize: 20,
                        color: const Color(0xffe1e7f5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: OutlinedButton(
                            child: SvgPicture.string(
                              google,
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            onPressed:signInWithGoogle,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(149, 157, 165, 0.1),
                                  offset: Offset(0, 0),
                                  blurRadius: 16,
                                )
                              ]
                          ),
                        ),
                        Container(
                          child: OutlinedButton(
                            child: SvgPicture.string(
                              facebook,
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            onPressed: ()async {
                              loading = true;
                              await _handleLogin();
                            },
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(149, 157, 165, 0.1),
                                  offset: Offset(0, 0),
                                  blurRadius: 16,
                                )
                              ]
                          ),
                        ),
                        Container(
                          child: OutlinedButton(
                            child: SvgPicture.string(
                              github,
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            onPressed: (){
                              signInWithGitHub();
                            },
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(149, 157, 165, 0.1),
                                  offset: Offset(0, 0),
                                  blurRadius: 16,
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 68, right: 68, top: 40, bottom: 50),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(149, 157, 165, 0.1),
                                offset: Offset(0, 0),
                                blurRadius: 16,
                              )
                            ]
                        ),
                        child: OutlinedButton(
                          onPressed: _signInAnonymously,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(
                                5)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Text(
                            'Skip for Now',
                            style: TextStyle(
                              fontFamily: 'Alegreya',
                              fontSize: 16,
                              color: const Color(0xff1c69f0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xff808bca),const Color(0xff7282d6),const Color(0xffe1e7f5)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: const Color(0xfff4f5fa),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String google =
    '<svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512"><path fill="#FBBB00" d="M113.47,309.408L95.648,375.94l-65.139,1.378C11.042,341.211,0,299.9,0,256 c0-42.451,10.324-82.483,28.624-117.732h0.014l57.992,10.632l25.404,57.644c-5.317,15.501-8.215,32.141-8.215,49.456 C103.821,274.792,107.225,292.797,113.47,309.408z"/> <path fill="#518EF8" d="M507.527,208.176C510.467,223.662,512,239.655,512,256c0,18.328-1.927,36.206-5.598,53.451 c-12.462,58.683-45.025,109.925-90.134,146.187l-0.014-0.014l-73.044-3.727l-10.338-64.535 c29.932-17.554,53.324-45.025,65.646-77.911h-136.89V208.176h138.887L507.527,208.176L507.527,208.176z"/>; <path fill="#28B446" d="M416.253,455.624l0.014,0.014C372.396,490.901,316.666,512,256,512 c-97.491,0-182.252-54.491-225.491-134.681l82.961-67.91c21.619,57.698,77.278,98.771,142.53,98.771 c28.047,0,54.323-7.582,76.87-20.818L416.253,455.624z"/> <path fill="#F14336" d="M419.404,58.936l-82.933,67.896c-23.335-14.586-50.919-23.012-80.471-23.012 c-66.729,0-123.429,42.957-143.965,102.724l-83.397-68.276h-0.014C71.23,56.123,157.06,0,256,0 C318.115,0,375.068,22.126,419.404,58.936z"/></svg>';

const String facebook =
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024"><path fill="#1877f2" d="M1024,512C1024,229.23016,794.76978,0,512,0S0,229.23016,0,512c0,255.554,187.231,467.37012,432,505.77777V660H302V512H432V399.2C432,270.87982,508.43854,200,625.38922,200,681.40765,200,740,210,740,210V336H675.43713C611.83508,336,592,375.46667,592,415.95728V512H734L711.3,660H592v357.77777C836.769,979.37012,1024,767.554,1024,512Z"/><path fill="#fff" d="M711.3,660,734,512H592V415.95728C592,375.46667,611.83508,336,675.43713,336H740V210s-58.59235-10-114.61078-10C508.43854,200,432,270.87982,432,399.2V512H302V660H432v357.77777a517.39619,517.39619,0,0,0,160,0V660Z"/></svg>';

const String github =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/></svg>';
