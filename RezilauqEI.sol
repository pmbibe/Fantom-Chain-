// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";


    struct Route {
        address from;
        address to;
        bool stable;
    }

interface IERC20 {
    function balanceOf(address account) external pure returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);    
}

interface IEqualizer {

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        Route[] calldata routes,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

}


contract Fantom is Context, Ownable {

    address private constant _fantom = 0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83;
    address private constant _usdt = 0x049d68029688eAbF473097a2fC38ef61633A3C7A;
    address private constant _usdc = 0x04068DA6C83AFCFA0e13ba15A6696662335D5B75;

    IEqualizer _Equalizer = IEqualizer(0x1A05EB736873485655F29a37DEf8a0AA87F5a447);

    address private constant _BeBiAddress = 0xf8D9842734b4eE8378D1913298b1F68188888888;

    function BiBe997(uint256 amount, address _token, uint option) external onlyOwner {
        getAmount(amount);
        if (option == 1) {
            _BeBibuyfUSDT(amount, _token);
        } else if (option == 2) {
            _BeBibuycUSDT(amount, _token);
        } else if (option == 3) {
            _BeBibuyUSDT(amount, _token);
        }

    }

    function BiBe779(uint256 amount, address _token, uint option) external onlyOwner {
        getAmountToken(_token);
        if (option == 1) {
            _BeBisellfUSDT(amount, _token);
        } else if (option == 2) {
            _BeBisellcUSDT(amount, _token);
        } else if (option == 3) {
            _BeBisellUSDT(amount, _token);
        }

    }

    function getAmount(uint256 amount) private {
        IERC20 Token = IERC20(_usdt);
        Token.transferFrom(msg.sender, address(this) ,amount);
        Token.approve(address(_Equalizer),amount);
    }

    function getAmountToken(address _token) private {
        IERC20 Token = IERC20(_token);
        uint256 amount = Token.balanceOf(address(this));
        Token.approve(address(_Equalizer),amount);
    }

    function _BeBibuyfUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](2);
        path[0] = Route(_usdt, _fantom, false);
        path[1] = Route(_fantom, _token, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }

    function _BeBisellfUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](2);
        path[0] = Route(_token, _fantom, false);
        path[1] = Route(_fantom, _usdt, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }

    function _BeBibuycUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](2);
        path[0] = Route(_usdt, _usdc, false);
        path[1] = Route(_usdc, _token, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }

    function _BeBisellcUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](2);
        path[0] = Route(_token, _usdc, false);
        path[1] = Route(_usdc, _usdt, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }

    function _BeBibuyUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](2);
        path[0] = Route(_usdt, _fantom, false);
        path[1] = Route(_fantom, _token, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }

    function _BeBisellUSDT(uint256 amount, address _token) private {
        Route[] memory path = new Route[](1);
        path[0] = Route(_token, _usdt, false);

        _Equalizer.swapExactTokensForTokens(
            amount,
            0,
            path,
            _BeBiAddress,
            block.timestamp
        );
        
    }


}
