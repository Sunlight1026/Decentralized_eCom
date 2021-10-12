/**
 * @author Pruthvi Kumar
 * @email pruthvikumar.123@gmail.com
 * @create date 2018-09-20 16:50:12
 * @modify date 2018-09-20 16:50:12
 * @desc Customer in our E-Com platform.
 */
pragma solidity ^0.5.12;

// We have to specify what version of compiler this code will compile with

contract Customer {
    /* Events */
    event OrderRaisedOrUpdated(uint256 idOrder);

    struct AvailableCustomer {
        uint256 idCustomer;
        bytes32 customerName;
    }

    struct Orderlog {
        uint256 idOrder;
        uint256 idCustomer;
        bytes32 itemName;
        uint256 quantity;
        bool status;
    }

    // STATE Variables.
    uint256 numberOfItemsPurchased;
    uint256 numberOfItemsReceived;

    // Mappings
    mapping(uint256 => AvailableCustomer) customers;
    mapping(uint256 => Orderlog) orderLogs;

    /* Constructor */
    constructor() public {
        /* For the case of demo, adding a customer in constructor. You can take this idea and extend the contract to contain addCustomer section and hence maintain customerDB in the Blockchain! */
        customers[0] = AvailableCustomer(1, "John Snow");
    }

    /* TRANSACTIONS */
    function purchaseItem(bytes32 itemName, uint256 quantity) public {
        uint256 idOrder = numberOfItemsPurchased++;
        orderLogs[idOrder] = Orderlog(idOrder, 0, itemName, quantity, false);
        emit OrderRaisedOrUpdated(idOrder);
    }

    function recieveItem(uint256 idOrder) public {
        numberOfItemsReceived++;
        orderLogs[idOrder].status = true;
        emit OrderRaisedOrUpdated(idOrder);
    }

    /* GETTERS */
    function getOrderDetails(uint256 idOrder)
        public
        view
        returns (
            bytes32,
            uint256,
            bool
        )
    {
        /*returns itemName, quantity & completionStatus*/
        return (
            orderLogs[idOrder].itemName,
            orderLogs[idOrder].quantity,
            orderLogs[idOrder].status
        );
    }

    function getNumberOfItemsPurchased() public view returns (uint256) {
        return numberOfItemsPurchased;
    }

    function getNumberOfItemsReceived() public view returns (uint256) {
        return numberOfItemsReceived;
    }
}
