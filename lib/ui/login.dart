import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class Login extends StatefulWidget {
 const Login({Key? key}) : super(key: key);
 @override
 State createState() => _LoginState();
}
class _LoginState extends State<Login> {
 // 1
 final _emailController = TextEditingController();
 // 2
 final _passwordController = TextEditingController();
 // 3
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 @override
 void dispose() {
 // 4
 _emailController.dispose();
 _passwordController.dispose();
 super.dispose();
 }
@override
Widget build(BuildContext context) {
 // 1
 final userDao = Provider.of<UserDao>(context, listen: false);
 return Scaffold(
 // 2
 appBar: AppBar(
 title: const Text('RayChat'),
 ),
 body: Padding(
 padding: const EdgeInsets.all(32.0),
 // 3
 child: Form(
 key: _formKey,
 child: Column(
 children: [
 Row(
 children: [
 const SizedBox(height: 80),
 Expanded(
 // 1
 child: TextFormField(
 decoration: const InputDecoration(
 border: UnderlineInputBorder(),
 hintText: 'Email Address',),
 autofocus: false,
 // 2
 keyboardType: TextInputType.emailAddress,
 // 3
 textCapitalization: TextCapitalization.none,
 autocorrect: false,// 4
 controller: _emailController,
 // 5
 validator: (String? value) {
 if (value == null || value.isEmpty) {
 return 'Email Required';
 }
 return null;
 },
 ),
 ),
 ],
 ),
Row(
 children: [
 const SizedBox(height: 20),
 Expanded(
 child: TextFormField(
 decoration: const InputDecoration(
 border: UnderlineInputBorder(), hintText: 'Password'),
 autofocus: false,
 obscureText: true,
 keyboardType: TextInputType.visiblePassword,
 textCapitalization: TextCapitalization.none,
 autocorrect: false,
 controller: _passwordController,
 validator: (String? value) {
 if (value == null || value.isEmpty) {
 return 'Password Required';
 }
 return null;
 },
 ),
 ), ],
),
const Spacer(),Row(
 children: [
 const SizedBox(height: 20),
 Expanded(
 child: ElevatedButton(
 // 1
 onPressed: () async {
 final errorMessage = await userDao.login(
 _emailController.text,
 _passwordController.text,
 );
 // 2
 if (errorMessage != null) {
 if (!mounted) return;
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
 content: Text(errorMessage),
 duration: const Duration(milliseconds: 700),
 ),);
 }
 },
 child: const Text('Login'),
 ),
 )
 ],
),
Row(
 children: [
 const SizedBox(height: 20),
 Expanded(
 child: ElevatedButton(
 // 3
 onPressed: () async {
 final errorMessage = await userDao.signup(
 _emailController.text,
 _passwordController.text,
 );
 if (errorMessage != null) {
 if (!mounted) return;
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
 content: Text(errorMessage),
 duration: const Duration(milliseconds: 700),
 ),);
 }
 },child: const Text('Sign Up'),
 ),
 ),
 const SizedBox(height: 60),
 ],
),
// TODO: Add parentheses
 ]
 ),
 ),
 ),
 );
 }
}
// TODO: Add Buttons