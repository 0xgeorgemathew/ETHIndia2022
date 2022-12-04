async function main() {
  // Grab the contract factory
  const SendEther = await ethers.getContractFactory("SendEther");

  // Start deployment, returning a promise that resolves to a contract object
  const sendEther = await SendEther.deploy(
    "0xcf33F6BAa21D90B22af8314eF6D3A47D6326389A",
    "0xc1eb04c600964e28b3b4c1b5eB7a58B71e6584EE"
  ); // Instance of the contract
  console.log("Contract deployed to address:", sendEther.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
