// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2;

import {Script, console} from "forge-std/Script.sol";
import {PunchSwapV2Factory} from "../src/PunchSwapV2Factory.sol";
import {PunchSwapV2Pair} from "../src/PunchSwapV2Pair.sol";

/*
    forge script ./script/PunchSwapV2FactoryDeploy.s.sol:PunchSwapV2FactoryDeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract PunchSwapV2FactoryDeployScript is Script {
    string public constant PARAM_OWNER = "OWNER";
    string public constant PARAM_PK_ACCOUNT = "PK_ACCOUNT";

    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address _owner = vm.envAddress(PARAM_OWNER);
        address _initialFeeToSetter = _owner;
        address _finalFeeToSetter = address(0x0);
        address _feeTo = address(0x0);

        console.log("Owner:                     ", _owner);
        console.log("Fee To:                    ", _feeTo);
        console.log("Initial Fee To Setter:     ", _initialFeeToSetter);
        console.log("Final Fee To Setter:       ", _finalFeeToSetter);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        PunchSwapV2Factory instance = new PunchSwapV2Factory(_initialFeeToSetter);

        console.log("PunchSwapV2Factory:    ", address(instance));
        console.log("PunchSwapV2Factory.INIT_CODE_PAIR_HASH:  ");
        bytes32 factoryHash = instance.INIT_CODE_PAIR_HASH();
        console.logBytes32(factoryHash);

        bytes memory bytecode = type(PunchSwapV2Pair).creationCode;
        bytes32 pairHash = keccak256(bytecode);
        console.log("PunchSwapV2Pair keccak256(bytecode): ");
        console.logBytes32(pairHash);

        require(
            factoryHash == pairHash,
            "PunchSwapV2Factory.INIT_CODE_PAIR_HASH != PunchSwapV2Pair keccak256(bytecode)"
        );
        console.log("Bytecode hashcode verified");

        instance.setFeeTo(_feeTo);
        console.log("Fee To:                    ", instance.feeTo());

        if (_finalFeeToSetter != _initialFeeToSetter) {
            instance.setFeeToSetter(_finalFeeToSetter);
            console.log("Fee To Setter:             ", instance.feeToSetter());
        }

        vm.stopBroadcast();
    }
}
