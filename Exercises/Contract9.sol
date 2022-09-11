//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

//Learning ERC-165, which let us check whether one contract implements a specific interface.
//The interface identifier of ERC165 interface is 0x01ffc9a7 
 //which is the result of bytes4(keccak256('supportsInterface(bytes4)')) and supportsInterface.selector

interface ERC165{
    function supportsInterface(bytes4 interfaceID) external view returns(bool);
}
contract ERC165Mapping is ERC165{
    mapping(bytes4 => bool) internal supportedInterfaces;
    constructor(){
        supportedInterfaces[this.supportsInterface.selector]=true; 
    }
    function supportsInterface(bytes4 interfaceID) external override view returns(bool){
        return supportedInterfaces[interfaceID];
    }
}
interface Numbers{
    function setNumber(uint256 _num) external;
    function getNumber() external view returns(uint256);
}
contract NumbersRooms is ERC165Mapping,Numbers{
    uint256 num;
    constructor(){
        supportedInterfaces[this.setNumber.selector ^ this.getNumber.selector] = true;
    }
    function setNumber(uint256 _num) external override{
        num=_num;
    }
    function getNumber() external override view returns(uint256){
        return num;
    }
}