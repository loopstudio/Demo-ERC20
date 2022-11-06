// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const DemoERC20 = await hre.ethers.getContractFactory("DemoERC20");
  const demoERC20 = await DemoERC20.deploy(
    "DemoERC20",
    "DERC",
    "1000000000000000000000"
  );

  await demoERC20.deployed();

  console.log("DemoERC20 deployed to:", demoERC20.address);
  console.log("Name:", await demoERC20.name());
  console.log("Symbol:", await demoERC20.symbol());
  console.log("Supply:", await (await demoERC20.totalSupply()).toString());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
