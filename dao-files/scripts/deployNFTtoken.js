async function main() {
  // Grab the contract factory
  const BigFalconNFT = await ethers.getContractFactory("BigFalconNFT");

  // Start deployment, returning a promise that resolves to a contract object
  const bigFalconNFT = await BigFalconNFT.deploy(); // Instance of the contract
  console.log("Contract deployed to address:", bigFalconNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
