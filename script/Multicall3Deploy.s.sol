// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import {Script, console} from "forge-std/Script.sol";
import {Consts} from "./Consts.sol";
import {Multicall3} from "../src/utils/Multicall3.sol";

/*
    forge script ./script/Multicall3Deploy.s.sol:Multicall3DeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract Multicall3DeployScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address _owner = vm.envAddress(PARAM_OWNER);
        console.log("Owner address:             ", _owner);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        Multicall3 instance = new Multicall3();

        vm.stopBroadcast();
        console.log("Multicall3:    ", address(instance));
    }
}