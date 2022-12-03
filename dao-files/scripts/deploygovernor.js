async function main() {
  // Grab the contract factory
  const BigFalconDAO = await ethers.getContractFactory("BigFalconDAO");

  // Start deployment, returning a promise that resolves to a contract object
  const bigFalconDAO = await BigFalconDAO.deploy(
    "0xa47783580808151Cf26373c8eD6777c14f3B5c34"
  ); // Instance of the contract taking token contract address as input
  console.log("Contract deployed to address:", bigFalconDAO.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
