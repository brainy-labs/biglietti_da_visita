import 'dart:collection';

import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({ Key? key }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  
  /// Global key that uniquely identifies the Form widget  and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  List<String> registrationFields = ['nome', 'cognome', 'mail', 'password', 'conferma Password'];
  final HashMap<String, TextEditingController> _controllers = HashMap();

  @override
  void initState() {
    super.initState();
    addController();
    print("init state");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrazione"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var item in registrationFields) 
                      TextFormField(
                        controller: _controllers[item],
                        decoration: InputDecoration(labelText: item),
                        autofocus: false,
                        validator: (value) => validate(item, value!),
                      ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: doRegister,
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 1, 29, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ) )   
          )
        )
      )
    );
  }
  doRegister () {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  validate(String field, String value){
    String pattern = "";

    if(value.isEmpty) {
      return 'Il campo $field non è compilato';
    } else if(field == 'mail') {
      pattern = r"^[a-zA-Z0-9.!#$%&'*+=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    }  else if(field =='password' || field == 'conferma Password') {
      pattern = r"^.{8,}$";
    } else if(field =='nome' || field == 'cognome') {
      pattern = r"^[A-Za-zèùàòé][a-zA-Z\'èùàòéì ]*$";
    }

    var regex = RegExp(pattern);
    if(!regex.hasMatch(value)) {
      return 'Il campo $field contiene uno o più errori';
    }
  }

  addController(){
    for (var e in registrationFields) {
      _controllers[e] = TextEditingController();
      _controllers[e]!.addListener(() { doSomething(e);});
    }
  }

  doSomething(e){
    print(_controllers[e]?.text??'No Value');
  }
}