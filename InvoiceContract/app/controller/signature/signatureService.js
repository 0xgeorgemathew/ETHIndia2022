const { ethers } = require("ethers");
const lighthouse = require('@lighthouse-web3/sdk');

exports.sign_auth_message = async(publicKey, privateKey) =>{
    console.log('Sign_auth_message');
    const provider = new ethers.providers.JsonRpcProvider();
    const signer = new ethers.Wallet(privateKey, provider);
    const messageRequested = (await lighthouse.getAuthMessage(publicKey)).data.message;
    const signedMessage = await signer.signMessage(messageRequested);
    return(signedMessage)
  }




