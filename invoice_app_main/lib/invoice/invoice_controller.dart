import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice/connection_controller.dart';

class InvoiceController extends GetxController with StateMixin {
  TextEditingController invoiceNumber = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController timeStamp = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  final box = GetStorage();
  late var cId, account, signedMessage;
  ConnectionController connectionController = Get.find();
  final jsonAbi = '''[
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_signerAddress",
                "type": "address"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "previousOwner",
                "type": "address"
            },
            {
                "indexed": true,
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "OwnershipTransferred",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "oldStr",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "string",
                "name": "newStr",
                "type": "string"
            }
        ],
        "name": "UpdatedResourceUrl",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "invoiceId",
                "type": "uint256"
            }
        ],
        "name": "findInvoiceById",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "invoiceNo",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "invoiceDate",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "invoiceTotal",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "timestamp",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "cId",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "userAddress",
                "type": "address"
            },
            {
                "internalType": "string",
                "name": "signedMessage",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getSigner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "invoiceNo",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "invoiceDate",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "invoiceTotal",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "userAddress",
                "type": "address"
            },
            {
                "internalType": "string",
                "name": "cId",
                "type": "string"
            },
            {
                "internalType": "string",
                "name": "signedMessage",
                "type": "string"
            }
        ],
        "name": "invoiceConfirm",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "renounceOwnership",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "signerAddress",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "transferOwnership",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]''';

  final humanReadableAbi = [
    "function invoiceConfirm(uint256 invoiceNo,uint256 invoiceDate,uint256 invoiceTotal,address userAddress,string memory cId,string memory signedMessage)", // Or "function addPerson((string name, uint16 age) person)"
  ];

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    cId = box.read('cId');
    account = box.read('account');
    signedMessage = box.read('Signed');
    super.onInit();
  }

  void sendContract() async {
    change(null, status: RxStatus.loading());
    // Contruct Interface object out of `humanReadableAbi` or `jsonAbi`
    final humanInterface = Interface(humanReadableAbi);
    final jsonInterface = Interface(jsonAbi);
    // These two abi interface can be exchanged
    humanInterface.format(FormatTypes
        .minimal); // [function balanceOf(address) view returns (uint256)]
    humanInterface.format(FormatTypes.minimal)[0] ==
        jsonInterface.format(FormatTypes.minimal)[0]; // true
    // Connect wallet to network
    final testnetProvider = JsonRpcProvider(
        'https://summer-bitter-asphalt.matic-testnet.discover.quiknode.pro/00624e84b86a64eb43a2229e1ca7ca871d95935b/');
    final anotherBusd = Contract(
      '0xc1eb04c600964e28b3b4c1b5eb7a58b71e6584ee',
      Interface(jsonAbi),
      provider!.getSigner(),
    );
    // Send 1 ether to `0xfoo`
    final tx = await anotherBusd.send('invoiceConfirm', [
      (invoiceNumber.text),
      (invoiceDate.text),
      (totalAmount.text),
      (timeStamp.text),
      '$account',
      '$cId',
      (invoiceNumber.text),
      '0x311d6FAe70D7473f6F2906dAEbf12E7D7a041F7b'
          '$signedMessage',
    ]);
    tx.hash; // 0xbar
  }
}
