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
        console.log("Owner address:             ", _owner);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        PunchSwapV2Factory instance = new PunchSwapV2Factory(_owner);

        console.log("PunchSwapV2Factory:    ", address(instance));

        bytes32 bytecodeHash = _getBytecodeHash();
        console.log("PunchSwapV2Factory bytecodeHash: ");
        console.logBytes32(bytecodeHash);


        /*bytes32 salt = 0x0000000000000000000000000000000000000001;
        
        ISystemContractDeployer deployer = ISystemContractDeployer(
            address(0x0000000000000000000000000000000000008006)
        );
        address addr = deployer.getNewAddressCreate2(
            address(this),
            salt,
            bytecodeHash,
            ""
        );
        */

        vm.stopBroadcast();
    }

    function _getBytecodeHash() internal returns (bytes32) {
        string memory artifact = vm.readFile(
            "zkout/PunchSwapV2Factory.sol/PunchSwapV2Factory.json"
        );
        bytes32 bytecodeHash = vm.parseJsonBytes32(artifact, ".hash");
        return bytecodeHash;
    }
}
