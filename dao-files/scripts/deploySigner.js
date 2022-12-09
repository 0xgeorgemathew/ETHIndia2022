async function main() {
  // Grab the contract factory
  const InvoiceSigner = await ethers.getContractFactory("InvoiceSigner");

  // Start deployment, returning a promise that resolves to a contract object
  const invoiceSigner = await InvoiceSigner.deploy(
    "0x493Edd749936B5d60d729a54AFcEF3793ede2209",
    "0xcf33F6BAa21D90B22af8314eF6D3A47D6326389A"
  ); // Instance of the contract
  console.log("Contract deployed to address:", invoiceSigner.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
