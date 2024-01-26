import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:seventh_chat_app/widgets/auth_form/auth_controls.dart';
import 'package:seventh_chat_app/widgets/auth_form/fields/auth_email.dart';
import 'package:seventh_chat_app/widgets/auth_form/fields/auth_password.dart';
import 'package:seventh_chat_app/widgets/auth_form/fields/auth_user_name.dart';
import 'package:seventh_chat_app/widgets/user_picker_image.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // form key is used to identify the form and validate it
  final _form = GlobalKey<FormState>();

  bool _isLogin = true;
  String _enteredEmail = '';
  String _enteredUsername = '';
  String _enteredPassword = '';
  bool _isAuthenticating = false;
  File? _selectedImage;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || _selectedImage == null && !_isLogin) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        await _signInUser();
        return;
      }

      await _createNewUser();
    } on FirebaseAuthException catch (e) {
      // on catch - handles only FirebaseAuthException
      _processError(e);
    }
  }

  Future<void> _signInUser() async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: _enteredEmail,
      password: _enteredPassword,
    );

    print(userCredential.user!.uid);
  }

  Future<void> _createNewUser() async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: _enteredEmail,
      password: _enteredPassword,
    );

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images') // folder will be created automatically
        .child('${userCredential.user!.uid}.jpg');

    await storageRef.putFile(_selectedImage!);

    final imageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'username': _enteredUsername,
      'email': _enteredEmail,
      'image_url': imageUrl,
    });
  }

  void _processError(FirebaseAuthException e) {
    if (e.code == 'email-already-in-use') {
      // ...
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? 'An error occurred!'),
      ),
    );

    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isLogin)
            UserImagePicker(
              onImagePicked: (pickedImage) {
                setState(() {
                  _selectedImage = pickedImage;
                });
              },
            ),
          AuthEmail(onSaved: (value) {
            _enteredEmail = value!;
          }),
          if (!_isLogin)
            AuthUsername(onSaved: (value) {
              _enteredUsername = value!;
            }),
          AuthPassword(onSaved: (value) {
            _enteredPassword = value!;
          }),
          const SizedBox(height: 12),
          AuthControls(
              isAuthenticating: _isAuthenticating,
              isLogin: _isLogin,
              submit: _submit,
              toggleLogin: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              }),
        ],
      ),
    );
  }
}
