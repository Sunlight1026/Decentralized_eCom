/**
 * @author Pruthvi Kumar
 * @email pruthvikumar.123@gmail.com
 * @create date 2018-09-20 16:50:12
 * @modify date 2018-09-20 16:50:12
 * @desc Supplier in our E-Com platform.
 */
pragma solidity ^0.5.12;

// We have to specify what version of compiler this code will compile with

contract Supplier {
    /* Events */
    event ItemAdded(uint256 idItem);
    event ProcessAnOrder(uint256 idOfCustomer, uint256 idOrder, bool status);

    struct Item {
        uint256 idItem;
        bytes32 itemName;
        uint256 price;
    }

    struct Orderlog {
        uint256 idOfCustomer;
        uint256 idOrder;
        bool status;
    }

    // STATE Variables.
    uint256 numberOfItemsAvailableForSale;
    uint256 numberOfOrdersProcessed;

    // Mappings
    mapping(uint256 => Item) items;
    mapping(uint256 => Orderlog) orderLogs;

    /* TRANSACTIONS */
    function addItem(bytes32 itemName, uint256 price) public {
        uint256 idItem = numberOfItemsAvailableForSale++;
        items[idItem] = Item(idItem, itemName, price);
        emit ItemAdded(idItem);
    }

    function processOrder(uint256 idOrder, uint256 idCustomer) public {
        orderLogs[idOrder] = Orderlog(idCustomer, idOrder, true);
        numberOfOrdersProcessed++;
        emit ProcessAnOrder(idCustomer, idOrder, true);
    }

    /* GETTERS */
    function getItem(uint256 idItem) public view returns (bytes32, uint256) {
        /*returns itemName and its price*/
        return (items[idItem].itemName, items[idItem].price);
    }

    function getStatus(uint256 idOrder) public view returns (bool) {
        /*returns completion status*/
        return (orderLogs[idOrder].status);
    }

    function getTotalNumberOfAvailableItems() public view returns (uint256) {
        return numberOfItemsAvailableForSale;
    }

    function getTotalNumberOfOrdersProcessed() public view returns (uint256) {
        return numberOfOrdersProcessed;
    }
}
