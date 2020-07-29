import 'package:braspag_silent_order_post_dart/silent_order_post.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  SilentOrderPostResponse response;
  ResponsePage({this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Braspag OAuth'),
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
                          response.foreignCard != null
                              ? Text('ForeignCard  : ${response.foreignCard}')
                              : Text(''),
                          response.binQueryReturnCode != null
                              ? Text(
                                  'BinQuery Return Code  : ${response.binQueryReturnCode}')
                              : Text(''),
                          response.brand != null
                              ? Text('Brand  : ${response.brand}')
                              : Text(''),
                          response.binQueryReturnMessage != null
                              ? Text(
                                  'BinQuery Return Message  : ${response.binQueryReturnMessage}')
                              : Text(''),
                          response.verifyCardStatus != null
                              ? Text(
                                  'VerifyCard Status  : ${response.verifyCardStatus}')
                              : Text(''),
                          response.verifyCardReturnCode != null
                              ? Text(
                                  'VerifyCard Return Code  : ${response.verifyCardReturnCode}')
                              : Text(''),
                          response.verifyCardReturnMessage != null
                              ? Text(
                                  'VerifyCard Return Message  : ${response.verifyCardReturnMessage}')
                              : Text(''),
                          response.cardBin != null
                              ? Text('CardBin  : ${response.cardBin}')
                              : Text(''),
                          response.cardLast4Digits != null
                              ? Text(
                                  'CardLast4Digits  : ${response.cardLast4Digits}')
                              : Text(''),
                          response.cardToken != null
                              ? Text('Card Token  : ${response.cardToken}')
                              : Text(''),
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
}
