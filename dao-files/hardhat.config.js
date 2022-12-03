/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const { API_URL, PRIVATE_KEY } = process.env;
module.exports = {
  etherscan: {
    apiKey: "MERWPDDCPJ3STI7MYX826G955XE3A4BDQA",
  },
  solidity: {
    version: "0.8.4",
    optimizer: {
      enabled: true,

      runs: 200,
    },
  },
  solidity: {
    version: "0.8.9",
    optimizer: {
      enabled: true,

      runs: 200,
    },
  },
  defaultNetwork: "mumbai",
  networks: {
    hardhat: {},
    mumbai: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};
