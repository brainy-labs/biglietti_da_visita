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
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var item in registrationFields) 
                      TextFormField(
                        decoration: InputDecoration(labelText: item),
                        autofocus: true,
                        validator: (value) => value == null || value.isEmpty ? 'Il campo $item contiene uno o più errori' : null,
                      ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: doRegister,
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 1, 29, 52),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          textStyle: TextStyle(
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
    _formKey.currentState!.validate();
    // if (_formKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Processing Data')),
    //   );
    // }
  }

}