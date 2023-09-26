import 'package:starknet/starknet.dart';

final provider = JsonRpcProvider.infuraGoerliTestnet;

// ignore_for_file: prefer_const_declarations

import 'package:starknet/starknet.dart';

final provider = JsonRpcProvider.infuraGoerliTestnet;
final contractAddress = '0x076b4f19561a3c48f13aa3cb912ad92c0e702270466668ec9d77513ba6c5b0e2';
final secretAccountAddress = "0x00ce7b8175e1aed7e087f44e63051c053cda012d5f63fdd1e95e82489925ff41";
final secretAccountPrivateKey = "0x06a1b5d41b7e5fee4310fda61d7c1b11e039f4681424cc89e1e8bfffe1ed9926";
   final signeraccount = getAccount(
  accountAddress:Felt.fromHexString(secretAccountAddress) ,
  privateKey: Felt.fromHexString(secretAccountPrivateKey) ,
  nodeUri: infuraGoerliTestnetUri,
);


Future<int> getCounter() async {
  final result = await provider.call(
    request: FunctionCall(
        contractAddress: Felt.fromHexString(contractAddress),
        entryPointSelector: getSelectorByName("curr"),
        calldata: []),
    blockId: BlockId.latest,
  );
  return result.when(
    result: (result) => result[0].toInt(),
    error: (error) => throw Exception("Failed to get counter value"),
  );
}

Future<bool> increaseCounter(String contractAddress) async {
  final response = await account.execute(functionCalls: [
    FunctionCall(
      contractAddress: Felt.fromHexString(contractAddress),
      entryPointSelector: getSelectorByName("incr"),
      calldata: [],
    ),
  ]);

  final txHash = response.when(
    result: (result) => result.transaction_hash,
    error: (err) => throw Exception("Failed to execute"),
  );
  return waitForAcceptance(transactionHash: txHash, provider: provider);
}

Future<> increaseby(String contractAddress, int amount) async {
//  final provider = JsonRpcProvider(nodeUri: uri)

    final res = await provider.call(
      request: FunctionCall(
          contractAddress: Felt.fromHexString(contractAddress),
          entryPointSelector: getSelectorByName("incrby"),
          calldata: [amount]
      ),
      blockId: BlockId.latest,
    );

  
  // final provider = providerFromArgs(globalResults);
  return Account(
    supportedTxVersion: AccountSupportedTxVersion.v1,
    accountAddress: Felt.fromHexString(globalResults?['account-address']),
    chainId: Felt.fromString(globalResults?['chain-id']),
    provider: provider,
    signer: Signer(
      privateKey: Felt.fromHexString(globalResults?['private-key']),
    ),
  );

 final res = await account
        .execute(functionCalls: [FunctionCall(...)]);
          return waitForAcceptance(transactionHash: txHash, provider: provider);

}

