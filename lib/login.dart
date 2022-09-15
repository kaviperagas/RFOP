import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/main.dart';
import 'package:rfop/providers/user.dart' show User;
import 'package:rfop/screens/table_number.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String pattern = r"^(01)[02-46-9][0-9]{7}$|^(01)[1][0-9]{8}$";
  late RegExp regExp = RegExp(pattern);

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mae-mu-rgRbqFweGF0-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()),
                      );
                    }),
                title: const Text('RFOP System'),
              ),
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: 400,
                    width: 375,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Z Restaurant',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Text(
                              'Please Enter Your Details',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: controllerName,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization: TextCapitalization.words,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter Your Name!';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                          (Set<MaterialState> states) {
                                    final Color color =
                                        states.contains(MaterialState.error)
                                            ? Theme.of(context).errorColor
                                            : Colors.black;
                                    return TextStyle(
                                        color: color, fontSize: 20);
                                  }),
                                  labelText: 'Name',
                                  hintText: 'Enter Your Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: controllerPhone,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Phone Number!';
                                  }
                                  if (!regExp.hasMatch(value)) {
                                    return 'Please Enter A Valid Phone Number! (01xxxxxxxx)';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                      final Color color =
                                          states.contains(MaterialState.error)
                                              ? Theme.of(context).errorColor
                                              : Colors.black;
                                      return TextStyle(
                                          color: color, fontSize: 20);
                                    },
                                  ),
                                  labelText: 'Phone Number',
                                  hintText: 'Enter Your Phone Number',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 3, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onPressed: () {
                                  userData.saveName(controllerName.text,
                                      controllerPhone.text);
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TablePage()),
                                    );
                                  }
                                },
                                child: const Text('Start Ordering'),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
