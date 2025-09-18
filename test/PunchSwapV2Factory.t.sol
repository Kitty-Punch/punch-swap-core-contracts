// SPDX-License-Identifier: MIT

pragma solidity >=0.6.2;

// import {console2 as console} from "forge-std/console2.sol";
//import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IPunchSwapV2Pair} from "../src/interfaces/IPunchSwapV2Pair.sol";
import {IPunchSwapV2Factory} from "../src/interfaces/IPunchSwapV2Factory.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";
import {ForkBaseTest} from "./utils/ForkBase.t.sol";
import {PunchSwapV2Factory} from "../src/PunchSwapV2Factory.sol";

contract PunchSwapV2FactoryForkTest is ForkBaseTest {
    address public constant WETH = address(0x9EDCde0257F2386Ce177C3a7FCdd97787F0D841d);
    address public constant USDC = address(0xe4C7fBB0a626ed208021ccabA6Be1566905E2dFc);
    address public constant V2_FACTORY = address(0x5bcBb2cE2b39F6F5Ac6da58bb3e267edCed0E6aD);
    uint256 public constant ONE_SHARE = 1e18;

    IPunchSwapV2Factory public v2Factory;

    function setUp() public {
        _createSelectFork(ABS_TESTNET);
        v2Factory = new PunchSwapV2Factory(V2_FACTORY);

        vm.label(address(v2Factory), "V2_FACTORY");
        vm.label(V2_FACTORY, "V2_FACTORY");
        vm.label(WETH, "WETH");
        vm.label(USDC, "USDC");
    }

    function test_getPair_valid() external {
        address _pair = v2Factory.getPair(WETH, USDC);
        assertEq(_pair, address(0), "!pair");
    }

    function test_createPair_valid() external {
        address _pair = v2Factory.createPair(WETH, USDC);
        assertNotEq(_pair, address(0), "!pair");
    }
}
