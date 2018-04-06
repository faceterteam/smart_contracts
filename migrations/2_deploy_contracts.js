var FaceterToken = artifacts.require("./FaceterToken.sol");
var FaceterTokenLock = artifacts.require("./FaceterTokenLock.sol");

module.exports = function(deployer) {
  deployer.deploy(FaceterToken, "0x...", "0x...");
  deployer.deploy(FaceterTokenLock);
};
