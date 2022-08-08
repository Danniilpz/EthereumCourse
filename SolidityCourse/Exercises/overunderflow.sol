pragma solidity >=0.7.0 <0.9.0;

import "./SafeMath.sol";

contract Votacion{
    mapping (address=>uint256) usuarios;

    using SafeMath for uint256;

    function sumarVotos(address _usuario, uint256 _numero) public{
        (,usuarios[_usuario])=usuarios[_usuario].tryAdd(_numero);
    }

    function restarVotos(address _usuario, uint256 _numero) public{
        (,usuarios[_usuario])=usuarios[_usuario].trySub(_numero);
    }
}