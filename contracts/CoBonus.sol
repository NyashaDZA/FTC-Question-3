pragma solidity^0.5.0;

import "./CoToken.sol";

contract CoBonus {

    //creates the struct
    struct Shoe {
        address payable owner; //address of the owner
        string name; //name of owner
        string image; //url of the image
        bool sold; // sold: true or false
    }

    // initialise variables
    //The price is 1CO, so 1 Co Token
    uint256 shoesSold = 0;
    uint256 count = 0;

    // Create the dynamic array of shoes
    Shoe[] public shoes;


    CoToken ownedToken;
    //The constructor mints 100 tokens
    constructor(address _ownedTokenAddress) public {
        for (uint i = 1; i <= 100; i++) {
        shoes.push(Shoe(msg.sender, "","",false));
        count++; // increase count each time a shoe is minted
        }
        ownedToken = CoToken(_ownedTokenAddress);
    }

    //Keep track of the total number of tokens minted
    function getNumberofTokens() public view returns(uint counts) {
        return shoes.length;
    }

    address public ownerAddress;

    //function allows for buying shoe by specifying the name and image on it, 

    function buyShoe(string memory _name, string memory _image) public payable returns(uint){ 
        //check there is at least 1 shoe not sold
        require(shoesSold < shoes.length, "All shoes have been sold);
                
        //The token onwer must have tokens
        require(ownedToken.balanceOf(msg.sender) > 0, "There are no Tokens available");
        //Address of the owner
        ownerAddress = ownedToken.owner();
        
        //If tokens are available they can be transferred to new owner
        require(ownedToken.transferFrom(msg.sender, ownerAddress, 1), "Transfer failed");
          
        uint256 i = shoesSold + 1; // increment the number of shoes sold by 1
        require(shoes[i].sold == false,' the shoe has been bought');
        
        //update the values of the next shoe
        shoes[i].owner = msg.sender;
        shoes[i].name = _name;
        shoes[i].image = _image;
        shoes[i].sold = true;
        shoesSold++; //increase counter
        return shoesSold;
    }


    //function to return an array of bools
    function checkPurchases() external view returns (bool[] memory){
        bool[] memory checkPurchase;
        for (uint256 i = 0; i < shoes.length; i++){
            if (shoes[i].owner == msg.sender){
                checkPurchase[i] = true;
            }
        }
        return checkPurchase;
    }

}