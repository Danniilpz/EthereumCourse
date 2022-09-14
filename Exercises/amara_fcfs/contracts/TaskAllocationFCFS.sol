// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract TaskAllocationFCFS {

    address payable public owner;
    uint256[] public tasksIds;
    address[] public userIds;
    enum Status{ //represents the status of one task
        AVAILABLE,
        ASSIGNED,
        COMPLETED
    }
    struct Task{ //represents a task
        address user;
        string name;
        Status status;   
        bool exists;     
    }
    struct User{ //represents a task
        string name;
        string language;
        uint256 task;
        bool free;
        bool exists;
    }
    mapping(uint256=>Task) tasks; //the existing tasks
    mapping(address=>User) users; //existing users
    mapping(address=>uint256) usersAndTasks; //links users with tasks

    modifier userFree(address _userId){
        require(users[_userId].free,"The user alredy have a task.");
        _;
    }
    modifier taskAvailable(uint256 _taskId){
        require(tasks[_taskId].status==Status.AVAILABLE,"The task is already assigned.");
        _;
    }
    modifier taskAssigned(uint256 _taskId){
        require(tasks[_taskId].status==Status.ASSIGNED,"The task is not assigned.");
        _;
    }
    modifier userExists(address _userId){
        require(users[_userId].exists,"The user does not exist.");
        _;
    }
    modifier userNotExists(address _userId){
        require(!users[_userId].exists,"The user already exists.");
        _;
    }
    modifier taskExists(uint256 _taskId){
        require(tasks[_taskId].exists,"The task does not exist.");
        _;
    }
    modifier taskNotExists(uint256 _taskId){
        require(!tasks[_taskId].exists,"The task alredy exists.");
        _;
    }
 
    event UserRegistered(address indexed _userId);
    event TaskCreated(uint256 indexed _taskId);
    event TaskAssigned(address indexed _userId,uint256 indexed _taskId);

    constructor() payable {
        owner = payable(msg.sender);
    }

    function createTask(uint256 _taskId,string memory _name) external 
        taskNotExists(_taskId) 
        returns(bool){
        
        if(_taskId==0){
           return false; 
        } 
        Task storage t=tasks[_taskId];
        t.user=address(0);
        t.name=_name;
        t.status=Status.AVAILABLE;
        t.exists=true; 
        tasksIds.push(_taskId);
        emit TaskCreated(_taskId);
        return true;
    }
    function registerUser(address _userId, string memory _name,string memory _language) external 
        userNotExists(_userId) 
        returns(bool){

        User storage u=users[_userId];
        u.name=_name;
        u.language=_language;    
        u.task=0;
        u.free=true;
        u.exists=true;    
        userIds.push(_userId);
        emit UserRegistered(_userId);
        return true;
    }
    function assignTask(address _userId, uint256 _taskId) external 
        userExists(_userId) taskExists(_taskId) userFree(_userId) taskAvailable(_taskId) 
        returns(bool){

        usersAndTasks[_userId]=_taskId;
        tasks[_taskId].user=_userId;
        tasks[_taskId].status=Status.ASSIGNED;
        users[_userId].task=_taskId;
        users[_userId].free=false;
        emit TaskAssigned(_userId,_taskId);
        return true;
    }
    function completeTask(uint256 _taskId) external 
        taskAssigned(_taskId)
        returns(bool){  

        tasks[_taskId].status=Status.COMPLETED;
        users[tasks[_taskId].user].task=0;
        users[tasks[_taskId].user].free=true;
        //payment to the user
        return true;
    }
    function getUserIds() public view returns(uint256){
        return userIds.length;
    }
    function getTaskIds() public view returns(uint256){
        return tasksIds.length;
    }
}
