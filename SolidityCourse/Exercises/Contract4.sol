pragma solidity >=0.7.0 <0.9.0;

contract Loteria{
    address internal owner;
    uint256 internal num;
    uint256 public numGanador;
    uint256 public precio;
    bool public juego;
    address public ganador;
    uint256[] ids;
    modifier juegoOn{
        require(juego);
        _;
    }
    modifier juegoOff{
        require(!juego);
        _;
    }
    modifier precioPagado{
        require(msg.value == precio);
        _;
    }
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }
    constructor(uint256 _numGanador, uint256 _precio) payable{
        owner = msg.sender;
        numGanador = _numGanador;
        precio = _precio;
    }
    function numeroRandom() private view returns(uint256){
        return uint256(keccak256(abi.encode(block.timestamp,msg.sender,num)))%10;
    }
    function comprobarAcierto(uint256 _num) private view returns(bool){
        if(numGanador == _num){
            return true;
        }
        else{
            return false;
        }
    }
    function participar() payable external juegoOn precioPagado returns(bool resultado, uint256 numero){
        uint256 numeroUsuario=numeroRandom();
        bool acierto=comprobarAcierto(numeroUsuario);
        if(acierto){
            payable(msg.sender).transfer(address(this).balance/2);
            juego=false;
            ganador=msg.sender;
        }
        else{
            resultado=false;
            num++;
            numero=numeroUsuario;
        }

    }
    function verPremio() public view returns(uint256){
        return juego?address(this).balance/2:0;
    }
    function retirarFondos() external onlyOwner juegoOff returns(uint256){
        payable(msg.sender).transfer(address(this).balance);
        return address(this).balance;
    }
}
    