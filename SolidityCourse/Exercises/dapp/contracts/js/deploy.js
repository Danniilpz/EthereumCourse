const HDWalletProvider= require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const { abi,bytecode } = require('./compile');

const mnemonic = "weasel govern exhaust tenant kangaroo negative private train cereal gadget monitor include";
const provider = new HDWalletProvider(mnemonic,'http://localhost:8545');

const web3 = new Web3(provider);

const deploy = async() => {
    const accounts = await web3.eth.getAccounts();

    const argumentsConstructor = [
        "Daniel Coin",
        "ACOIN",
        18,
        21000000
    ]

    const gasEstimate = await new web3.eth.Contract(abi)
        .deploy({data:bytecode, arguments: argumentsConstructor})
        .estimateGas({from: accounts[0]});

    const result = await new web3.eth.Contract(abi)
        .deploy({data:bytecode, arguments: argumentsConstructor})
        .send({gas:gasEstimate, from: accounts[0]});

    //console.log("Contract deployed to",result.options.address);
    console.log(JSON.stringify(result.options.jsonInterface));
}
deploy();
