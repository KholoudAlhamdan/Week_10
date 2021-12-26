pragma solidity ^0.8.0;

contract GoodLife {
    
    struct BankAccountRecord {

        uint customer_id;
        string full_name;
        string profession;
        string Date_Of_Birth;
        address wallet_Addr;
        string customer_addr;
    }

    uint number_of_accounts;

    BankAccountRecord[] bankAccountRecords;

    mapping(address=>uint) account_balancec;
    mapping(address=>uint) account_info_map;

    function registerAccount(string memory full_name_,string memory profession_,
    string memory Date_Of_Birth_,string memory customer_addr_) external {

    require(account_info_map[msg.sender] == 0, "Account already registered!");

        bankAccountRecords.push(
            BankAccountRecord({customer_id:++number_of_accounts,
            full_name:full_name_,
            profession:profession_,
            Date_Of_Birth:Date_Of_Birth_,
            wallet_Addr:msg.sender,
            customer_addr:customer_addr_
            })
        );
      
            account_info_map[msg.sender] = number_of_accounts;
            
    }


//8
    modifier onlyRegistered() {
        require(account_info_map[msg.sender]> 0, "user not Register, Please Registered");
        _;
    }

    function get_balance() external view onlyRegistered returns(uint) {
        return account_balancec[msg.sender];
    }

    function getAccountInfo() public onlyRegistered view returns (BankAccountRecord memory ) {

        return bankAccountRecords[account_info_map[msg.sender]-1];

    }

//10    

    function transfer(address recipient, uint amount) public {

        // require(account_balancec[msg.sender]>amount, "Insufficent founds!");
        account_balancec[msg.sender] -= amount;
        account_balancec[recipient] +=amount;
    
    }

//11
    function withdrawl(uint amount ) public onlyRegistered {

        // require(account_balancec[msg.sender]>amount, "Insufficent founds!");

        account_balancec[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        
    }

//12
    receive () external payable {
        account_balancec[msg.sender] +=msg.value;
    }

}
