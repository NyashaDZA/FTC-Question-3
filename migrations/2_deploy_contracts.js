    
const CoToken = artifacts.require("./CoToken.sol");
const CoBonus = artifacts.require("./CoBonus.sol");

module.exports = function(deployer) {
    deployer.deploy(CoToken, "CoToken", "CO", 0).then((contractInstance) => {
    deployer.deploy(CoBonus, contractInstance.address);
  })

}

// module.exports = async function(deployer) {
//   deployer.deploy(COToken, "CoToken", "CO", 0).then(function(){
//          await deployer.deploy(CoShoe, COToken.address)
// });
// };

// module.exports = async function(deployer) {
//   const COTokenInstance = deployer.deploy(COToken, "CoToken", "CO", 0);

//   await deployer.deploy(CoShoe, COTokenInstance.address)
// };