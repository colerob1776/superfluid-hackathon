// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.4.24;

import "./ISuperfluid.sol";
import "./ISuperToken.sol";
import "./ISuperApp.sol";

contract SuperAppBase is ISuperApp {

    function beforeAgreementCreated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*ctx*/
    )
        external
        view
        returns (bytes memory /*cbdata*/)
    {
        revert("Unsupported callback - Before Agreement Created");
    }

    function afterAgreementCreated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*cbdata*/,
        bytes /*ctx*/
    )
        external
        returns (bytes memory /*newCtx*/)
    {
        revert("Unsupported callback - After Agreement Created");
    }

    function beforeAgreementUpdated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*ctx*/
    )
        external
        view
        returns (bytes memory /*cbdata*/)
    {
        revert("Unsupported callback - Before Agreement updated");
    }

    function afterAgreementUpdated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*cbdata*/,
        bytes /*ctx*/
    )
        external
        returns (bytes memory /*newCtx*/)
    {
        revert("Unsupported callback - After Agreement Updated");
    }

    function beforeAgreementTerminated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*ctx*/
    )
        external
        view
        returns (bytes memory /*cbdata*/)
    {
        revert("Unsupported callback -  Before Agreement Terminated");
    }

    function afterAgreementTerminated(
        ISuperToken /*superToken*/,
        address /*agreementClass*/,
        bytes32 /*agreementId*/,
        bytes /*agreementData*/,
        bytes /*cbdata*/,
        bytes /*ctx*/
    )
        external
        returns (bytes memory /*newCtx*/)
    {
        revert("Unsupported callback - After Agreement Terminated");
    }

}
