// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract SimpleStorage {
    uint256 storedData;
    address owner = msg.sender;
    uint256 reward = 50 ether;

    struct User {
        string title;
        uint balance;
        string deadline;
        address ownerAddress;
        bool isCompleted;
    }

    User[] public users;

    event TaskCreated(string indexed _title, uint balance, string _deadline, address indexed _ownerAddress, bool _isCompleted);

    function createTask (string memory _title, string memory _deadline, address _ownerAddress) public {
        users.push(User({title: _title, balance: 0 ether, deadline: _deadline, ownerAddress: _ownerAddress, isCompleted: false}));
        emit TaskCreated(_title, 0 ether, _deadline, _ownerAddress, false);
    }

    function rewardUser (uint256 _index) internal {
        require(users[_index].isCompleted == true, "Complete your task");
        users[_index].balance += reward;
    }

    function updateTask(uint256 _index) public {
        require(users[_index].ownerAddress == msg.sender, "Not the owner");
        users[_index].isCompleted = true;
        rewardUser(_index);
    }

    function get(uint _index) public view returns (string memory, uint256, string memory, address, bool) {
        return (users[_index].title, users[_index].balance, users[_index].deadline, users[_index].ownerAddress, users[_index].isCompleted);
    }
}