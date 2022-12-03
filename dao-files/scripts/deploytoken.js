async function main() {
  // Grab the contract factory
  const BigFalconToken = await ethers.getContractFactory("BigFalconToken");

  // Start deployment, returning a promise that resolves to a contract object
  const bigFalconToken = await BigFalconToken.deploy(); // Instance of the contract
  console.log("Contract deployed to address:", bigFalconToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
