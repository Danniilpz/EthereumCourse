//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

//Learning libraries

library L{
    //function returnAddress() public view returns(address){   In this case two contracts will be deployed
    function returnAddress() internal view returns(address){ //In this case the libray will be embedded in the contract, 
                                                             //and only it will be deployed
        return address(this);
    }
}

contract Main {
    function a() public view returns(address){
        return L.returnAddress(); 
        //It will return the address of the contract.
    }
}

library CounterLib{
    struct Counter{
        uint256 i;
    }
    event Incremented(uint256); //if the event is duplicated in the contract and the library, it can be emitted from the library. 
    function increment(Counter storage _counter) internal returns(uint256){
        uint256 total=_counter.i+1;
        emit Incremented(total);
        return ++_counter.i;
    }

}

contract CounterContract{
    using CounterLib for CounterLib.Counter;
    CounterLib.Counter public counter;
    event Incremented(uint256);
    function increment() public returns (uint256){
        return counter.increment();
    }
}