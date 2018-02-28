var FaceterToken = artifacts.require("./FaceterToken.sol");
var FaceterTokenLock = artifacts.require("./FaceterTokenLock.sol");

module.exports = function(deployer) {
  deployer.deploy(FaceterToken);
  deployer.deploy(FaceterTokenLock);
};