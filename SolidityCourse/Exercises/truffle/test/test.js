
const Hello = artifacts.require("Hello");

contract('Hello',accounts =>{
    it('Obtener mensaje', async () =>{
        let instance = await Hello.deployed();
        const msg = await instance.getMessage.call({from:accounts[0]});
        assert.equal(msg, 'Hola Mundo');
    });
    it('Cambiar mensaje', async () =>{
        let instance = await Hello.deployed();
        const tx = await instance.setMessage('Chaoo',{from:accounts[4]});
        const msg = await instance.getMessage.call({from:accounts[4]});
        assert.equal(msg, 'Chaoo');
    });
});