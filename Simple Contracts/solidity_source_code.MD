pragma solidity ^0.8.0;

contract EmptyContract {} // 

contract same {

    string public massage;

    constructor (string memory massage) {
        massage = massage;
    }

}

contract Bank{
    mapping(address=>uint) public account_balancec;
    
    function transfer(uint amount, address accToTransferTo) external {

        account_balancec[msg.sender] -= amount;
        account_balancec[accToTransferTo] += amount;

    }
    
    function BankBalance() external view returns(uint){return address(this).balance;}

    function withdraw(uint amount) external {

        account_balancec[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

    }

    receive () external payable {      

        account_balancec[msg.sender] += msg.value;
    
    }

 }
