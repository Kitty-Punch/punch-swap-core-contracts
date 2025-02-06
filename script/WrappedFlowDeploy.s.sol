// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Consts} from "./Consts.sol";
import {WrappedFlow} from "../src/utils/WrappedFlow.sol";

/*
    forge script ./script/WrappedFlowDeploy.s.sol:WrappedFlowDeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract WrappedFlowDeployScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        uint256 _owner = vm.envUint(PARAM_OWNER);
        console.log("Owner address:             ", _owner);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        WrappedFlow instance = new WrappedFlow();

        vm.stopBroadcast();
        console.log("WrappedFlow:    ", address(instance));
    }
}