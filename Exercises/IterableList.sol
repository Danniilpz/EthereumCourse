pragma solidity >=0.7.0 <0.9.0;

//Iterable list of users using mapping

contract IterableList {
    mapping(address => address) public users;
    uint256 public listSize;
    address constant public FIRST_ADDRESS = address(1);
    constructor(){
        users[FIRST_ADDRESS]=FIRST_ADDRESS;
    }
    function isInList(address _address) view internal returns(bool){
        return users[_address]!=address(0);
    }
    function addUser(address _address) public{
        require(!isInList(_address));
        users[_address]=users[FIRST_ADDRESS];
        users[FIRST_ADDRESS]=_address;
        listSize++;
    }
    function getPrevUser(address _address)view internal returns(address){
        address currentAddress=FIRST_ADDRESS;
        while(users[currentAddress]!=FIRST_ADDRESS){
            if(users[currentAddress]==_address){
                return currentAddress;
            }
            currentAddress=users[currentAddress];
        }
        return FIRST_ADDRESS;
    }
    function removeUser(address _address) public{
        require(isInList(_address));
        address prevUser=getPrevUser(_address);
        users[prevUser]=users[_address];
        users[_address]=address(0);     
        listSize--;  
    }
    function getAllUsers() view public returns(address[] memory){
        address[] memory usersArray=new address[](listSize);
        address currentAddress=users[FIRST_ADDRESS];
        for(uint256 i=0;currentAddress!=FIRST_ADDRESS;i++){
            usersArray[i]=currentAddress;
            currentAddress=users[currentAddress];
        }
        return usersArray;
    }
}