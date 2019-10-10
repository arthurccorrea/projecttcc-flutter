import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Future<http.Response> _barbearia = BarbeariaApi.getBarbearia("123");

class FutureTest extends StatefulWidget {

  @override
  _FutureTestState createState() => _FutureTestState();
}

class _FutureTestState extends State<FutureTest> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: FutureBuilder<http.Response>(
        future: _barbearia, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              return Text('Result: ${snapshot.data}');
          }
          return null; // unreachable
        },
      ),
    );
  }
}