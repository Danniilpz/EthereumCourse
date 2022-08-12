//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

//Learning Modifier and Require

contract Coches{
    address owner;
    uint256 precio;
    uint256[] ids;
    mapping(address => Coche) coches;
    struct Coche{
        uint256 id;
        string marca;
        uint32 caballos;
        uint32 kilometros;
    }
    modifier precioFiltro(uint256 _precio){
        require(_precio == precio);
        _;
    }
    constructor(uint256 _precio) {
        owner = msg.sender;
        precio = _precio;
    }
    function addCoche(uint256 _id,string memory _marca, uint32 _caballos, uint32 _kilometros) public precioFiltro(msg.value) payable {
        ids.push(_id);
        coches[msg.sender].id = _id;
        coches[msg.sender].marca = _marca;
        coches[msg.sender].caballos = _caballos;
        coches[msg.sender].kilometros = _kilometros;
    }
    function getIds() external view returns(uint256){
        return ids.length;
    }
    function getCoche() external view returns(string memory marca, uint32 caballos, uint32 kilometros){
        marca =coches[msg.sender].marca;
        caballos=coches[msg.sender].caballos;
        kilometros=coches[msg.sender].kilometros;
    }
}
    