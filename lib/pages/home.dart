import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voting_dapp/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_rinkbyURL, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting DApp'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Start Election')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
