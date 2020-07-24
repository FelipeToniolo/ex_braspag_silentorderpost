import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:flutter/material.dart';

import 'response_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo OAuth Braspag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerName = TextEditingController(text: "Darth Vader");

  final _controllerNumber = TextEditingController(text: "4111111111111111");

  final _controllerExpiration = TextEditingController(text: "01/2030");

  final _controllerCvv = TextEditingController(text: "123");

  bool _tokenize = true;
  bool _verify = true;
  bool _binQuery = true;

  var showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Braspag Silent Order Post'),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.body2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: TextFormField(
                              controller: _controllerName,
                              decoration: InputDecoration(
                                labelText: "Nome",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.zero)),
                                labelStyle: TextStyle(fontSize: 25),
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerNumber,
                                decoration: InputDecoration(
                                  labelText: "Numero do Cartão",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerExpiration,
                                decoration: InputDecoration(
                                  labelText: "Data de expiração",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerCvv,
                                decoration: InputDecoration(
                                  labelText: "CVV",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Cartão Protegido'),
                              Switch(
                                  value: this._tokenize,
                                  onChanged: (bool value) {
                                    setState(() => this._tokenize = value);
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Consulta BIN'),
                              Switch(
                                  value: this._binQuery,
                                  onChanged: (bool value) {
                                    setState(() => this._binQuery = value);
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Zero Auth'),
                              Switch(
                                  value: this._verify,
                                  onChanged: (bool value) {
                                    setState(() => this._verify = value);
                                  })
                            ],
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              _sendCard();
                              setState(() {});
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 200, minHeight: 50),
                              alignment: Alignment.center,
                              child: showProgress
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "Test",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _sendCard({String name, String number, String expiration, String cvv}) async {
    try {
      showProgress = true;

      print("Send Card");

      name = _controllerName.text;
      number = _controllerNumber.text;
      expiration = _controllerExpiration.text;
      cvv = _controllerCvv.text;

      var sop = SilentOrderPost(
          merchantId: 'Merchant Id',
          enviroment: SilentOrderPostEnviroment.SANDBOX);

      sop.binQuery = _binQuery;
      sop.verifyCard = _verify;
      sop.tokenize = _tokenize;

      var response = await sop.sendCardData(
          request: SilentOrderPostRequest(
              cardHolder: name,
              cardNumber: number,
              cardExpirationDate: expiration,
              cardSecurityCode: cvv));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsePage(response: response),
        ),
      );
    } on ErrorResponse catch (e) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            showProgress = false;
          });
          Navigator.pop(context);
        },
      );

      WillPopScope alert = WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Silent Order Post"),
          content: Text(e.message),
          actions: [
            okButton,
          ],
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      print("--------------------------------------");
      print('Code => ${e.code}');
      print('Message: ${e.message}');
      print("--------------------------------------");
    }
    showProgress = false;
  }
}
