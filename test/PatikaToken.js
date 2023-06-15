const PatikaToken = artifacts.require("PatikaToken");

contract("PatikaToken", (accounts) => {
  let contract;

  before(async () => {
    contract = await PatikaToken.deployed();
  });

  it("should have correct initial values", async () => {
    const name = await contract.name();
    const symbol = await contract.symbol();
    const decimals = await contract.decimals();
    const totalSupply = await contract.totalSupply();
    const contractBalance = await contract.balanceOf(contract.address);

    assert.equal(name, "Patika", "Incorrect name");
    assert.equal(symbol, "PTK", "Incorrect symbol");
    assert.equal(decimals, 18, "Incorrect decimals");
    assert.equal(
      totalSupply.toString(),
      "1000000000000000000000000",
      "Incorrect total supply"
    );
    assert.equal(
      contractBalance.toString(),
      "1000000000000000000000000",
      "Incorrect contract balance"
    );
  });

  it("should have total supply in the contract", async () => {
    const totalSupply = await contract.totalSupply();
    assert(
      totalSupply.toString() !== "0",
      "Total supply is not present in the contract"
    );
  });

  it("should execute the airdrop function", async () => {
    const recipient = accounts[0]; // Airdrop işlemini başlatan kullanıcı
    const initialRecipientBalance = await contract.balanceOf(recipient);

    await contract.airdrop();

    const newRecipientBalance = await contract.balanceOf(recipient);

    assert(
      newRecipientBalance.toString() > initialRecipientBalance.toString(),
      "Airdrop function did not transfer tokens to the recipient"
    );
  });
});

// Contract: PatikaToken
//     ✔ should have correct initial values (45ms)
//     ✔ should have total supply in the contract
//     ✔ should execute the airdrop function (69ms)


//   3 passing (216ms)