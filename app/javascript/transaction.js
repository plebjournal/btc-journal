document.getElementById('transaction_btc_unit').addEventListener("change", function(ev) {
  const btcAmountInput = document.getElementById('transaction_btc')
  const unitsSelected = ev.target.value

  if (unitsSelected === 'BTC') {
    btcAmountInput.value = btcAmountInput.value / 100_000_000;
  }
  if (unitsSelected === 'Sats') {
    btcAmountInput.value = Math.round(btcAmountInput.value * 100_000_000);
  }
})