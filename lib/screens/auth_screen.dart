import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF26BB9B),
                      Color(0xFF00B0BD),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 1])),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // color: Colors.red,
                height: deviceSize.height - 30,
                width: deviceSize.width,
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 0,
                        child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            radius: deviceSize.width * 0.22,
                            child: Image.asset('assets/icons/0-18.png')),
                      ),
                      Flexible(
                          child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'Welcome!',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anton'),
                        ),
                      )),
                      const Flexible(
                        child: AuthCard(),
                        flex: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {'email': '', 'password': ''};

  bool isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _submit() async {
    // if(!_formKey.currentState!.validate()){
    //   return;
    // }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      // dbHelper.insertData();
      // await dbHelper.openDb();
      // dbHelper.insertPlace(Users(5, _authData['email']!, _authData['password']!));
      // List<Users> users = await dbHelper.getUsers();
      // print('${users[5].id}');
    } catch (err) {
      var errMessage = 'Could not authenticate you. please try again later';
      _showErrorDialog(err.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error Occurred'),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SizedBox(
      width: deviceSize.width * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.white, width: 2)),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'username'),
                // keyboardType: TextInputType.emailAddress,
                // validator: (val) {
                //   if (val!.isEmpty || !val.contains('@')) {
                //     return 'Inavalid email';
                //   }
                // },
                onSaved: (val) {
                  _authData['email'] = val!;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.white, width: 2)),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Password',
                  border: InputBorder.none,
                ),
                obscureText: true,
                controller: _passwordController,
                // validator: (val) {
                //   if (val!.isEmpty || val.length < 5) {
                //     return 'Password is too short';
                //   }
                // },
                onSaved: (val) {
                  _authData['password'] = val!;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // if (isLoading)
            //   const CircularProgressIndicator()
            ElevatedButton(
              child: isLoading ? CircularProgressIndicator() : Text('Log In'),
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFA227),
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  minimumSize: const Size(double.infinity, 34)),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0F6671),
                  textStyle: TextStyle(fontSize: 20),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(double.infinity, 34)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Modyle Name : ASSET TRACKING',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Internal Version',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
              ),
            ),
            const Text(
              'V 1.0.0',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'DGI SYSTEM',
              style: TextStyle(
                color: Color(0xFF0F6671),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
