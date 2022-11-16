const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("Assets tests", () => {
    let MyNft;

    let myNft;

    const BASE_URI = "ipfs://QmTTYN4gqxs6ouqUiMsu6ARPeAHmfoQL6yJrhnXcpVSjDi/";

    beforeEach(async () => {
        MyNft = await ethers.getContractFactory("MyNft");
        myNft = await MyNft.deploy(BASE_URI);

        [owner, address1] = await ethers.getSigners();
    });

    it("seccesful mint", async () => {
        await myNft.connect(owner).mint(address1.address);
        expect(await myNft.balanceOf(address1.address)).eql(ethers.BigNumber.from(1));

        let tokenId = await myNft.tokenOfOwnerByIndex(address1.address, 0);
        let uri = await myNft.tokenURI(tokenId);
        expect(uri).eql(BASE_URI + 1 + ".json");
    })
});