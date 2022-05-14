// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce {

    //  creating struct for product
    struct Product = {
        string title;
        string description;
        address payable  seller;
        uint price;
        address buyer;
        bool delivered
    }
}