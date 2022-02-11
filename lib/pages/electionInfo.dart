import 'package:flutter/material.dart';
import 'package:voting_dapp/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final String electionName;
  final Web3Client ethClient;
  const ElectionInfo(
      {Key? key, required this.electionName, required this.ethClient})
      : super(key: key);

  @override
  _ElectionInfoState createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController candidatetextEditingController =
      TextEditingController();
  TextEditingController votertextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getCandidatesNum(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Candidates')
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    Text(
                      '0',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    Text('Votes')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: candidatetextEditingController,
                    decoration: InputDecoration(
                        filled: true, hintText: 'Enter Candidate Name'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      addCandidate(candidatetextEditingController.text,
                          widget.ethClient);
                    },
                    child: Text('Done'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: votertextEditingController,
                    decoration: InputDecoration(
                        filled: true, hintText: 'Authorize Voter Address'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      authorizeVoter(
                          votertextEditingController.text, widget.ethClient);
                    },
                    child: Text('Done'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
