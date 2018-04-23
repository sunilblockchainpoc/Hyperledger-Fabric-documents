/**
 * Track the trade of a commodity from one trader to another
 * @param {org1.example.com.Trade} trade - the trade to be processed
 * @transaction
 */
function tradeCommodity(trade) {
    trade.commodity.owner = trade.newOwner;
    return getAssetRegistry('org1.example.com.Commodity')
    .then(function (assetRegistry) {
    return assetRegistry.update(trade.commodity);
    });
}