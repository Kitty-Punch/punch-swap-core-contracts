pragma solidity >=0.6.2;

interface IPunchSwapV2Callee {
    function punchSwapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
