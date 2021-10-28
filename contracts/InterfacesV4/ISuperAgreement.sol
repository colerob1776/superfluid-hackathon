pragma solidity ^0.4.24;


interface ISuperAgreement {

    /**
     * @dev Get the type of the agreement class.
     */
    function agreementType() external view returns (bytes32);


}