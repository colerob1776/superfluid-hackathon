// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;


import "@aragon/os/contracts/apps/AragonApp.sol";

import "./InterfacesV4/SuperAppBase.sol";


import "./InterfacesV4/ISuperfluid.sol";
import "./InterfacesV4/ISuperToken.sol";
import "./InterfacesV4/ISuperApp.sol";

import "./InterfacesV4/IConstantFlowAgreementV1.sol";

import "./InterfacesV4/ISuperAgreement.sol";






contract EvenFlow is AragonApp, SuperAppBase{
    bytes32 internal _ctxStamp;


    bytes32 constant public CREATE_FLOW_ROLE = keccak256('CREATE_FLOW_ROLE');
    bytes32 constant public UPDATE_FLOW_ROLE = keccak256('UPDATE_FLOW_ROLE');
    bytes32 constant public DELETE_FLOW_ROLE = keccak256('DELETE_FLOW_ROLE');

    ISuperfluid private _host; // host
    IConstantFlowAgreementV1 private _cfa; // the stored constant flow agreement class address

    ISuperToken private _testToken;
    address _testReceiver;
    int96 _testFlow;
    


    // ISuperToken private _acceptedToken; // accepted token
    // address private _receiver;

    // mapping (address => ISuperToken) _superToken;
    mapping(address => int96) _receiverFlow;


    constructor(
        ISuperfluid host,
        IConstantFlowAgreementV1 cfa) public {
        require(address(host) != address(0), "host is zero address");
        require(address(cfa) != address(0), "cfa is zero address");
        // require(address(acceptedToken) != address(0), "acceptedToken is zero address");
        // require(address(receiver) != address(0), "receiver is zero address");
        // require(!host.isApp(ISuperApp(receiver)), "receiver is an app");

        _host = host;
        _cfa = cfa;
        // _acceptedToken = acceptedToken;
        // _receiver = receiver;


        uint256 configWord =
            1 << 1 | // SuperAppDefinitions.APP_LEVEL_FINAL |
            1 << (32 + 0) | // SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP |
            1 << (23 + 2) | // SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP |
            1 << (32 + 4); // SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;
            

        _host.registerApp(configWord);
    }

    function intialize() public onlyInit {
        initialized();
    }

    /**************************************************************************
     * External Calls
     *************************************************************************/

    function newFlow(
        ISuperToken superToken,
        address receiver,
        int96 flowRate
    )
        auth(CREATE_FLOW_ROLE) external
    {   
        require(receiver != address(0), "New receiver is zero address");
        // @dev because our app is registered as final, we can't take downstream apps
        require(!_host.isApp(ISuperApp(receiver)), "New receiver can not be a superApp");
        (bytes memory newCtx) = _host.callAgreement(
              _cfa,
              abi.encodeWithSelector(
                  _cfa.createFlow.selector,
                  superToken,
                  receiver,
                  flowRate,
                  new bytes(0)
              ),
              '0x'
          );
          _testToken = superToken;
          _testReceiver = receiver;
          _testFlow = flowRate;

    }

    function deleteFlow(
        ISuperToken superToken,
        address receiver
    )
        auth(DELETE_FLOW_ROLE) external
    {   
        require(receiver != address(0), "New receiver is zero address");
        // @dev because our app is registered as final, we can't take downstream apps
        (bytes memory newCtx) = _host.callAgreement(
              _cfa,
              abi.encodeWithSelector(
                  _cfa.deleteFlow.selector,
                  superToken,
                  address(this),
                  receiver,
                  new bytes(0) // placeholder
              ),
              '0x'
          );

    }

    function updateFlow(
        ISuperToken superToken,
        address receiver,
        int96 flowRate
    )
        auth(UPDATE_FLOW_ROLE) external
    {   
        require(receiver != address(0), "New receiver is zero address");
        // @dev because our app is registered as final, we can't take downstream apps
        require(!_host.isApp(ISuperApp(receiver)), "New receiver can not be a superApp");
        (bytes memory newCtx) = _host.callAgreement(
              _cfa,
              abi.encodeWithSelector(
                  _cfa.updateFlow.selector,
                  superToken,
                  receiver,
                  flowRate,
                  new bytes(0) // placeholder
              ),
              '0x'
          );

    }




    // /**
    //  * @dev ABIv2 Encoded memory data of context
    //  *
    //  * NOTE on backward compatibility:
    //  * - Non-dynamic fields are padded to 32bytes and packed
    //  * - Dynamic fields are referenced through a 32bytes offset to their "parents" field (or root)
    //  * - The order of the fields hence should not be rearranged in order to be backward compatible:
    //  *    - non-dynamic fields will be parsed at the same memory location,
    //  *    - and dynamic fields will simply have a greater offset than it was.
    //  */
    // struct Context {
    //     //
    //     // Call context
    //     //
    //     // callback level
    //     uint8 appLevel;
    //     // type of call
    //     uint8 callType;
    //     // the system timestsamp
    //     uint256 timestamp;
    //     // The intended message sender for the call
    //     address msgSender;

    //     //
    //     // Callback context
    //     //
    //     // For callbacks it is used to know which agreement function selector is called
    //     bytes4 agreementSelector;
    //     // User provided data for app callbacks
    //     bytes userData;

    //     //
    //     // App context
    //     //
    //     // app allowance granted
    //     uint256 appAllowanceGranted;
    //     // app allowance wanted by the app callback
    //     uint256 appAllowanceWanted;
    //     // app allowance used, allowing negative values over a callback session
    //     int256 appAllowanceUsed;
    //     // app address
    //     address appAddress;
    //     // app allowance in super token
    //     ISuperfluidToken appAllowanceToken;
    // }

    // function getContext(bytes4 agreementSelector) internal returns(bytes ctx){
    //     //Build context data
    //     ctx = _createContext(Context({
    //         appLevel: isApp(ISuperApp(address(this))) ? 1 : 0,
    //         callType: 1,
    //         /* solhint-disable-next-line not-rely-on-time */
    //         timestamp: block.timestamp,
    //         msgSender: address(this),
    //         agreementSelector: agreementSelector,
    //         userData: '0x',
    //         appAllowanceGranted: 0,
    //         appAllowanceWanted: 0,
    //         appAllowanceUsed: 0,
    //         appAddress: address(0),
    //         appAllowanceToken: ISuperfluidToken(address(0))
    //     }));

    //     return ctx;
    // }

    // function isApp(ISuperApp app) public view returns (bool){
    //     return _host.isApp(app);
    // }


    


    // function _createContext(Context memory context)
    //     private
    //     returns (bytes ctx)
    // {
    //     uint256 callInfo = ContextDefinitions.encodeCallInfo(context.appLevel, context.callType);
    //     uint256 allowanceIO =
    //         uint128(context.appAllowanceGranted) |
    //         (uint256(uint128(context.appAllowanceWanted)) << 128);
    //     ctx = abi.encode(
    //         abi.encode(
    //             callInfo,
    //             context.timestamp,
    //             context.msgSender,
    //             context.agreementSelector,
    //             context.userData
    //         ),
    //         abi.encode(
    //             allowanceIO,
    //             context.appAllowanceUsed,
    //             context.appAddress,
    //             context.appAllowanceToken
    //         )
    //     );
    
    //     return ctx;
    // }
}
