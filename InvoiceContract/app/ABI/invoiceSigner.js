module.exports =  [
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
]