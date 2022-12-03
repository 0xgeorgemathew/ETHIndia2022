//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
 
contract InvoiceSigner is Ownable {

    struct Invoice {
        uint256 invoiceNo;
        uint256 invoiceDate;
        uint256 invoiceTotal;
        uint256 timestamp;
        address signer;
        string cId;
        address userAddress;
    }

    mapping(uint256 => Invoice) invoice;

    address[] invoiceGeneratedUsers;
    uint256 Id = 0;


    string private invoiceNumber; 
    string private resourceUrl; 
    address public signerAddress; 
    string private signatureUrl; 
    bool completed;

    event UpdatedResourceUrl(string oldStr, string newStr);

    constructor(address _signerAddress) {
        signerAddress = _signerAddress;
    }


function invoiceConfirm(uint256 invoiceNo,  uint256 invoiceDate, uint256 invoiceTotal, 
    address userAddress, string memory cId, string memory _signatureUrl) public {
        require(address(msg.sender) == this.signerAddress(), "Only the designated signer can call the signer contract");
        signatureUrl = _signatureUrl;

        // uint256 count = invoiceGeneratedUsers.length;
        uint256 invoiceId = Id++;
        invoice[invoiceId] = Invoice({
            invoiceNo: invoiceNo,
            invoiceDate: invoiceDate,
            invoiceTotal: invoiceTotal,
            timestamp: block.timestamp,
            signer: msg.sender,
            cId: cId,
            // index: count,
            userAddress: userAddress
        });

        invoiceGeneratedUsers.push(userAddress);
    }


    function getResourceUrl() public view returns (string memory) {
        return resourceUrl;
    }

    // Only the owner can see the signer's completed signature.
    function getSignatureUrl() public view onlyOwner returns (string memory) {
        return signatureUrl;
    }

    function getSigner() public view returns (address) {
        return signerAddress;
    }

}