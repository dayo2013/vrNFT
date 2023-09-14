import { ethers } from "hardhat";

async function main(){

    let nft = ["_vrfCoordinator","_linkToken","_keyHash","_fee" ]

    const NFT = await ethers.deployContract("DYgame",[nft])


      await NFT.waitForDeployment();
      console.log(NFT.target);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  