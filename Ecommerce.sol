// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce {

    // Manager
    address payable manager;
    constructor(){
        manager = payable(msg.sender);
    }

    //  creating struct for product
    struct Product {
        string title;
        string description;
        address payable seller;
        uint productId;
        uint price;
        address buyer;
        bool delivered;
    }



    uint randomId = 1;

    // All the products will be stored in this products array.
    Product[] public products;

    // is not destroyed boolean
     bool isDestroyed = false;

    // Events
    event registered(string title, uint productId, address seller);
    event baught(uint productId, address buyer);
    event delivered(uint productId);




   // Modifier to prevent the self destruct problem.
   modifier isNotDestroyed{
       require(!isDestroyed, "Contract is not available");
       _;
   }




    // To Register a product.
    function registerProducts(string memory _title, string memory _description, uint _price) public isNotDestroyed {
      require(_price > 0, "Minimum price required is 1.");
      Product memory tempProduct;
      tempProduct.title=_title;
      tempProduct.description = _description;
      tempProduct.price = _price * 10**18;
      tempProduct.seller = payable(msg.sender);
      tempProduct.productId = randomId;
      products.push(tempProduct);
      randomId++;
      emit registered(_title, tempProduct.productId, msg.sender);
    }


    // To buy the product
    function buy(uint _productId) payable public isNotDestroyed {
        require(products[_productId - 1].price == msg.value, "Amount should be exact");
        require(products[_productId - 1].seller != msg.sender, "Seller cannot buy their own item.");
        products[_productId - 1].buyer = msg.sender;
        emit baught(_productId, msg.sender);
    }


    // confirm the delivery of product by buyer.
    function delivery(uint _productId) public isNotDestroyed {
       require(products[_productId - 1].buyer == msg.sender, "Sorry. You are not the buyer.");
       products[_productId-1].delivered = true;
       products[_productId-1].seller.transfer(products[_productId-1].price);
       emit delivered(_productId);
    }


    // To destroy the smart contract and send the money back to manager.
    function destroy() public isNotDestroyed{
        require(msg.sender == manager);
        manager.transfer(address(this).balance);
        isDestroyed = true;
    }














}