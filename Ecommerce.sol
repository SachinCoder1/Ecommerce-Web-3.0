// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce {

    //  creating struct for product
    struct Product = {
        string title;
        string description;
        address payable  seller;
        uint productId;
        uint price;
        address buyer;
        bool delivered
    }


   uint randomId = 1;
    Product[] public products;

    function registerProducts(string _title, string _description, uint _price) public {
      require(_price > 0, "Minimum price required is 1.")
      Product memory tempProduct;
      tempProduct.title=_title;
      tempProduct.description = _description,
      tempProduct.price = _price;
      tempProduct.seller = payable(msg.sender);
      tempProduct.productId = randomId;
      products.push(tempProduct);
      randomId++;

    }








}