const lighthouse = require('@lighthouse-web3/sdk');
const SignatureService = require('./signatureService')
const Dotenv = require('dotenv');
Dotenv.config({
    silent: true,
  });
console.log(process.env.apiKey)
const apiKey = process.env.apiKey
const publicKey = process.env.publicKey;
const privateKey = process.env.privateKey;

exports.signTransaction = async(req, res) => {
  
    try {
       
        const path = req.file.path
        let {userAddress } = req.body
        const signed_message = await SignatureService.sign_auth_message(publicKey, privateKey);
        console.log('signed_message',  signed_message);

        const response = await lighthouse.uploadEncrypted(
                path,
                apiKey,
                publicKey,
                signed_message
              ); 
        console.log(response);
        const ipfsLink = `https://ipfs.io/ipfs/${response.data.Hash}`
        const cId= response.data.Hash ;
        console.log( cId , 'CID');

    //     if(cId) {
    //     console.log('eer');
    //     const contract = new web3.eth.Contract(ABI, InvoiceSignerContract)
    //     console.log(contract.methods);
    //     const txnData = contract.methods.invoiceConfirm(invoiceNo,invoiceDate,invoiceTotal, userAddress, cId,signed_message).encodeABI();
    //     // const txnData = contract.methods.invoiceConfirm(104,1670058199,100, userAddress, cId,signed_message).encodeABI();
    //     // const txnData = "0xa3450c65000000000000000000000000000000000000000000000000000000000000006500000000000000000000000000000000000000000000000000000000638b10d7000000000000000000000000000000000000000000000000000000000000006400000000000000000000000068fc4b6d4e736063d0ed4bb75c48b415b93e6b0200000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000120000000000000000000000000000000000000000000000000000000000000002e516d64366f50787863565379315475683677697147526d39744e355436627746325a4b5978575135355033707236000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008430783964313234616435626464316139333238383335386237633765636430346231316137343363373564373363356337626262666466633665633365336261663630623930626432626133663836666137373030346139623461623734383134303262333632656563656336383331373334333239336338343733633137636665316300000000000000000000000000000000000000000000000000000000"
    //     let gasPrice = await web3.eth.getGasPrice();
    //     let nonce = await web3.eth.getTransactionCount(publicKey);

    //     console.log(gasPrice);
    //     console.log(nonce)
    //     const rawTxn = {
    //         to: web3.utils.toChecksumAddress(InvoiceSignerContract),
    //         from: web3.utils.toChecksumAddress(publicKey),
    //         nonce: web3.utils.toHex(nonce),
    //         gasPrice: web3.utils.toHex(gasPrice),
    //         gasLimit: web3.utils.toHex(100000),
    //         data: web3.utils.toHex(txnData),
    //         value: web3.utils.toHex(0),
    //         // chainId: 80001
    //     };
    //     console.log('rawTxn', rawTxn);
    //     const tx = new Tx(rawTxn, {
    //         chainId: 80001
    //     });
    //     tx.sign(privKey);
    //     let serializedTx = tx.serialize();
    //     console.log('serializedTx', serializedTx);
    //    let trans = await web3.eth.sendSignedTransaction(signedTransaction)
    //    console.log(trans);
    //     // web3.eth.sendSignedTransaction(serializedTx, async (err, hash) => {
    //     //     if (!err) {
    //     //         console.log('Txn Sent and hash is ' + hash);
    //     //         const jobScheduler = schedule.scheduleJob('txnJob/' + new Date(), '* */2 * * * *', async () => { // for every 50 sec
    //     //         console.log("Scheduler is Running: For calculating transaction hash for new user registers")
    //     //         const transactionReceipt = await web3.eth.getTransactionReceipt(hash);
    //     //         console.log("Receipt", transactionReceipt);
    //     //         console.log('Hash is ' + hash);
    //     //         if (transactionReceipt != null) {   
    //     //             jobScheduler.cancel();
    //     //             }
    //     //         });
    //     //     } else {
    //     //         console.error("Error in executing transaction: ", err);
    //     //     }
    //     //     });
    //     }
        
        res.send({
            success: true,
            message: "File signed successfully",
            data: {
                userAddress: userAddress,
                cId : response.data.Hash ,
                ipfsLink: ipfsLink
            }

        })
    

    } catch (error) {
        res.send({
            success: false,
            message: "Internal Error", 
        })
    }

}

exports.verifyTransaction = async(req, res) =>{
    try {
        console.log('Here');
        // const {cId } = req.body
        const cId = "QmW6nfxHPNNY3VZv9jmwhdwaHDGqDQcVaBf1hRxJUNf5KY"
        // console.log(req.body);
         // Get file encryption key
        const signed_message = await SignatureService.sign_auth_message(publicKey, privateKey);
        const fileEncryptionKey = await lighthouse.fetchEncryptionKey(
            cId,
            publicKey,
            signed_message
        );
        console.log('fileEncryptionKey', fileEncryptionKey);
        // Decrypt File
        const decrypted = await lighthouse.decryptFile(
            cId,
            fileEncryptionKey.data.key
        );
        console.log('decrypted', decrypted);
        // Save File
        fs.createWriteStream("Liz_ETHGlobalTickets.pdf").write(Buffer.from(decrypted))  
    } catch (error) {
        
    }
}