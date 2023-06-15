const PatikaToken = artifacts.require("PatikaToken");
const fs = require("fs");

module.exports = async function (deployer) {
  await deployer.deploy(PatikaToken);
  const instance = await PatikaToken.deployed();
  let PatikaTokenAddress = await instance.address;

  let config = "export const PatikaTokenAddress = " + PatikaTokenAddress;

  console.log("export const PatikaTokenAddress =  + PatikaTokenAddress")

  let data = JSON.stringify(config);

  fs.writeFileSync("config.js", JSON.parse(data));
};