pragma solidity >= 0.5.0 < 0.6.0;

import "github.com/provable-things/ethereum-api/provableAPI_0.5.sol";

contract LiquidationRatio is usingProvable {

    uint256 public lr;

    event LogNewLiquidationRatio(string lr);
    event LogNewProvableQuery(string description);

    constructor()
        public
    {
        update(); // First check at contract creation...
    }

    function __callback(
        bytes32 myid,
        string memory result
    )
        public
    {
        // require(msg.sender == provable_cbAddress());
        emit LogNewLiquidationRatio(result);
        uint256 liquid_ratio = parseInt(result, 2); 
        lr = liquid_ratio;
    }

    function peek()
        public returns (uint256)
    {
        return lr;
    }

    function update()
        public
        payable
    {
        emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        // TODO: Change this to the correct endpoint
        provable_query(60, "URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
    }
}