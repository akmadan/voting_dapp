import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voting_dapp/pages/electionInfo.dart';
import 'package:voting_dapp/services/functions.dart';
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
  TextEditingController textEditingController = TextEditingController();

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
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(filled: true),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      startElection(textEditingController.text, ethClient!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ElectionInfo(
                                  ethClient: ethClient!,
                                  electionName: textEditingController.text)));
                    },
                    child: Text('Start Election')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
