// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.4.24;
// This is required by the batchCall and decodeCtx
pragma experimental ABIEncoderV2;

import { ISuperfluidToken } from "./ISuperfluidToken.sol";
import "./ISuperApp.sol";
import "./ISuperAgreement.sol";


/**
 * @dev Superfluid host interface.

 * It is the central contract of the system where super agreement, super app
 * and super token features are connected together.
 *
 * The superfluid host contract is also the entry point for the protocol users,
 * where batch call and meta transaction are provided for UX improvements.
 *
 * @author Superfluid
 */
interface ISuperfluid {


    /**
     * @dev Message sender declares it as a super app
     * @param configWord The super app manifest configuration, flags are defined in
     *                   `SuperAppDefinitions`
     */
    function registerApp(uint256 configWord) external;


    /**
     * @dev Query if the app is registered
     * @param app Super app address
     */
    function isApp(ISuperApp app) external view returns(bool);



    /**************************************************************************
     * Contextless Call Proxies
     *
     * NOTE: For EOAs or non-app contracts, they are the entry points for interacting
     * with agreements or apps.
     *
     * NOTE: The contextual call data should be generated using
     * abi.encodeWithSelector. The context parameter should be set to "0x",
     * an empty bytes array as a placeholder to be replaced by the host
     * contract.
     *************************************************************************/

     /**
      * @dev Call agreement function
      * @param callData The contextual call data with placeholder ctx
      * @param userData Extra user data being sent to the super app callbacks
      */
     function callAgreement(
         ISuperAgreement agreementClass,
         bytes callData,
         bytes userData
     )
        external
        //cleanCtx
        returns(bytes memory returnedData);


    

    function callAgreementWithContext(
        ISuperAgreement agreementClass,
        bytes callData,
        bytes userData,
        bytes ctx
    )
        external
        // validCtx(ctx)
        // onlyAgreement(agreementClass)
        returns (bytes memory newCtx, bytes memory returnedData);

}