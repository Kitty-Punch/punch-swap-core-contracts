pragma solidity >=0.6.2;

import './interfaces/IPunchSwapV2Pair.sol';
import './interfaces/IPunchSwapV2Factory.sol';
import './PunchSwapV2Pair.sol';

contract PunchSwapV2Factory is IPunchSwapV2Factory {
    address public feeTo;
    address public feeToSetter;
bytes32 public constant INIT_CODE_PAIR_HASH =
        keccak256(abi.encodePacked(type(PunchSwapV2Pair).creationCode));

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'PunchSwapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'PunchSwapV2: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'PunchSwapV2: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(PunchSwapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IPunchSwapV2Pair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'PunchSwapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'PunchSwapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
