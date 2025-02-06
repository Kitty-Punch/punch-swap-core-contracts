// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2;

import {Script, console} from "forge-std/Script.sol";
import {PunchSwapV2Factory} from "../src/PunchSwapV2Factory.sol";

/*
    forge script ./script/PunchSwapV2FactorySetFeeTo.s.sol:PunchSwapV2FactorySetFeeToScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract PunchSwapV2FactorySetFeeToScript is Script {
    string public constant PARAM_OWNER = "OWNER";
    string public constant PARAM_PK_ACCOUNT = "PK_ACCOUNT";

    function run() external {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address _executor = vm.addr(deployerPrivateKey);
        PunchSwapV2Factory instance = PunchSwapV2Factory(address(0x0));
        address _newFeeTo = address(0x0);

        console.log("PunchSwapV2Factory:    ", address(instance));
        console.log("Executor:              ", _executor);
        console.log("Fee To:                ", instance.feeTo());
        console.log("Fee To Setter:         ", instance.feeToSetter());
        console.log("New Fee To:            ", _newFeeTo);

        vm.startBroadcast(deployerPrivateKey);
        instance.setFeeTo(_newFeeTo);
        vm.stopBroadcast();

        console.log("\n\nfactory.setFeeTo() executed\n\n");

        console.log("Current Fee To:    ", instance.feeTo());
        console.log("Fee To Setter:     ", instance.feeToSetter());
        console.log("New Fee To:        ", _newFeeTo);
    }
}
