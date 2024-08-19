// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2;

import "forge-std/Script.sol";
import {PunchSwapV2Factory} from "../src/PunchSwapV2Factory.sol";
import {PunchSwapV2Pair} from "../src/PunchSwapV2Pair.sol";

/*
    forge script ./script/PunchSwapV2FactoryVerifyInitCodePairHash.s.sol:PunchSwapV2FactoryVerifyInitCodePairHashScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract PunchSwapV2FactoryVerifyInitCodePairHashScript is Script {
    function run() public view {
        PunchSwapV2Factory instance = PunchSwapV2Factory(
            address(0xc9cAE05d068Ee58e55b39369b3098Eb275F1De57)
        );
        console.log("PunchSwapV2Factory:      ", address(instance));
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

        console.log("Code hashcode verified");
    }
}
