class TransactionModel {
  final dynamic blockNumber;
  final dynamic blockHash;
  final dynamic timeStamp;
  final dynamic hash;
  final dynamic nonce;
  final dynamic transactionIndex;
  final dynamic from;
  final dynamic to;
  final dynamic value;
  final dynamic gas;
  final dynamic gasPrice;
  final dynamic input;
  final dynamic methodId;
  final dynamic functionName;
  final dynamic contractAddress;
  final dynamic cumulativeGasUsed;
  final dynamic txReceiptStatus;
  final dynamic gasUsed;
  final dynamic confirmations;
  final dynamic isError;

  TransactionModel({
    this.blockNumber,
    this.blockHash,
    this.timeStamp,
    this.hash,
    this.nonce,
    this.transactionIndex,
    this.from,
    this.to,
    this.value,
    this.gas,
    this.gasPrice,
    this.input,
    this.methodId,
    this.functionName,
    this.contractAddress,
    this.cumulativeGasUsed,
    this.txReceiptStatus,
    this.gasUsed,
    this.confirmations,
    this.isError,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      blockNumber: json['blockNumber'],
      blockHash: json['blockHash'],
      timeStamp: json['timeStamp'],
      hash: json['hash'],
      nonce: json['nonce'],
      transactionIndex: json['transactionIndex'],
      from: json['from'],
      to: json['to'],
      value: json['value'],
      gas: json['gas'],
      gasPrice: json['gasPrice'],
      input: json['input'],
      methodId: json['methodId'],
      functionName: json['functionName'],
      contractAddress: json['contractAddress'],
      cumulativeGasUsed: json['cumulativeGasUsed'],
      txReceiptStatus: json['txreceipt_status'],
      gasUsed: json['gasUsed'],
      confirmations: json['confirmations'],
      isError: json['isError'],
    );
  }
}
