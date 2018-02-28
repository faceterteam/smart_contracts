pragma solidity 0.4.19;

/**
 *     ╔═══  Faceter Token Lock Contract
 *  ══ ╠══   This smart-contract is used to lock the team tokens for 2 years.
 *    ═╝     It is deployed at https://etherscan.io/address/0x4695c7AC68eb86c1079c7d7D53Af2F42DB8a6799
 *    ══     http://faceter.io
 */

contract ERC20Interface {
    function balanceOf(address _owner) public view returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
}

contract FaceterTokenLock {
    address constant RECEIVER = 0x102aEe443704BBd96f31BcFCA9DA8E86f0128803;
    uint constant AMOUNT = 18750000 * 10**18;
    ERC20Interface constant FaceterToken = ERC20Interface(0x4695c7AC68eb86c1079c7d7D53Af2F42DB8a6799);
    uint8 public unlockStep;

    function unlock() public returns(bool) {
        uint unlockAmount = 0;
        // Jun 1, 2018
        if (unlockStep == 0 && now >= 1527811200) {
            unlockAmount = AMOUNT;
        // Oct 1, 2018
        } else if (unlockStep == 1 && now >= 1538352000) {
            unlockAmount = AMOUNT;
        // Jan 1, 2019
        } else if (unlockStep == 2 && now >= 1546300800) {
            unlockAmount = AMOUNT;
        // Apr 1, 2019
        } else if (unlockStep == 3 && now >= 1556668800) {
            unlockAmount = AMOUNT;
        // Jul 1, 2019
        } else if (unlockStep == 4 && now >= 1561939200) {
            unlockAmount = AMOUNT;
        // Oct 1, 2019
        } else if (unlockStep == 5 && now >= 1569888000) {
            unlockAmount = AMOUNT;
        // Jan 1, 2020
        } else if (unlockStep == 6 && now >= 1577836800) {
            unlockAmount = AMOUNT;
        // Apr 1, 2020
        } else if (unlockStep == 7 && now >= 1585699200) {
            unlockAmount = FaceterToken.balanceOf(this);
        }
        if (unlockAmount == 0) {
            return false;
        }
        unlockStep++;
        require(FaceterToken.transfer(RECEIVER, unlockAmount));
        return true;
    }

    function () public {
        unlock();
    }

    function recoverTokens(ERC20Interface _token) public returns(bool) {
        // Do not allow to recover Faceter Token till the end of lock
        if (_token == FaceterToken && now < 1585699200 && unlockStep != 8) {
            return false;
        }
        return _token.transfer(RECEIVER, _token.balanceOf(this));
    }
}