import 'package:flutter/services.dart';
import 'package:voting_dapp/utils/constants.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddresss = contractAddress;
  final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'Election'), //Contract.sol
      EthereumAddress.fromHex(contractAddresss));
  return contract;
}

Future<List<dynamic>> query(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> callFunction(String funcName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentails = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result = await ethClient.sendTransaction(
      credentails,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callFunction("startElection", [name], ethClient, ownerPrivateKey);
  print('Election Started Successfully');
  return response;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response =
      await callFunction("addCandidate", [name], ethClient, ownerPrivateKey);
  print('Candidate Added Successfully');
  return response;
}

Future<List> getCandidatesNum(Web3Client ethClient) async {
  List<dynamic> result = await query('getNumCandidates', [], ethClient);
  return result;
}

Future<String> authorizeVoter(Web3Client ethClient) async {
  var response = await callFunction("authorizeVoter",
      [EthereumAddress.fromHex(voterAddress)], ethClient, ownerPrivateKey);
  print('Candidate Authorized Successfully');
  return response;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  var response =
      await callFunction("vote", [candidateIndex], ethClient, voterPrivateKey);
  print('Candidate Voted Successfully');
  return response;
}
