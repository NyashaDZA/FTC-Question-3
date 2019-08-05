pragma solidity^0.5.0;


//import "github.com/OpenZeppelin/zeppelin-solidity/contracts/ownership/Ownable.sol";
//import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
//import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol";


//imports all required contracts
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Metadata.sol";

contract CoToken is Ownable, ERC20 {

    uint256 public _buyPrice;
    uint256 public _tokenSupply = 0; // initialise token supply to 0
    uint256 public _sellPrice;

    function buyPrice(uint256 _buyTokens) public returns (uint){
        // compute integral to get buy price
        _buyPrice = ((5*(10**15))*(_buyTokens)*(_buyTokens)) + ((2*10**17)*(_buyTokens)); 

    }

    function sellPrice(uint256 _buyTokens) public {    
        // compute integral to get buy price
        _sellPrice = ((5*(10**15))*(_buyTokens)*(_buyTokens)) + ((2*10**17)*(_buyTokens)); 
    }

    function mint(uint256 _n) public payable {
        // to mint, the message value must equal the buy price
        require(msg.value == _buyPrice, "The amount does not correspond to the price");
        _mint(msg.sender, _n);
        _tokenSupply = _tokenSupply + _n; // increase token supply by minted values
    }

    //Use only owner to ensure that only owner (Co) can burn tokens, 
    // he must send funds equivalent to sell price
    function burn(uint256 _x) onlyOwner public payable {
        require(msg.value == _sellPrice, "Insufficient funds");
        _burn(msg.sender, _x);
        _tokenSupply = _tokenSupply - _x; // decrease token supply by the amount sold

    }

    // Only the owner may call the self destruct function
    function destroy() public onlyOwner {
        selfdestruct(msg.sender); // parameter is owners address - in this case this will be msg.sender
    }

}