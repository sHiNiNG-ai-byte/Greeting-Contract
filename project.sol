// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Greeting Contract
 * @dev A simple smart contract that allows users to set and retrieve greeting messages
 * @author Your Name
 */
contract Project {
    
    // State variable to store the greeting message
    string private greeting;
    
    // State variable to store the owner's address
    address public owner;
    
    // Event emitted when greeting is updated
    event GreetingUpdated(string newGreeting, address updatedBy);
    
    // Constructor to set initial greeting and owner
    constructor(string memory _initialGreeting) {
        greeting = _initialGreeting;
        owner = msg.sender;
        emit GreetingUpdated(_initialGreeting, msg.sender);
    }
    
    /**
     * @dev Sets a new greeting message
     * @param _newGreeting The new greeting message to set
     */
    function setGreeting(string memory _newGreeting) public {
        require(bytes(_newGreeting).length > 0, "Greeting cannot be empty");
        greeting = _newGreeting;
        emit GreetingUpdated(_newGreeting, msg.sender);
    }
    
    /**
     * @dev Returns the current greeting message
     * @return The current greeting string
     */
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
    
    /**
     * @dev Returns a personalized greeting with the caller's address
     * @return A personalized greeting message
     */
    function getPersonalizedGreeting() public view returns (string memory) {
        return string(abi.encodePacked("Hello ", addressToString(msg.sender), "! ", greeting));
    }
    
    /**
     * @dev Helper function to convert address to string
     * @param _addr The address to convert
     * @return The string representation of the address
     */
    function addressToString(address _addr) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_addr)));
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';
        for (uint256 i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }
}

