import { createChart } from 'lightweight-charts';

const loadFiatValue = async () => {
  const data = await fetch('/api/fiat-value')
  return data.json();
}

const loadBtcStack = async () => {
  const data = await fetch('/api/portfolio')
  return data.json();
}

const loadCostBasis = async () => {
  const data = await fetch('/api/cost-basis')
  return data.json();
}

const oneYearDateRange = () => {
  const currentDate = new Date()
  return {
    from: new Date(currentDate.getFullYear() - 1, currentDate.getMonth(), currentDate.getDay()).getTime() / 1000,
    to: currentDate.getTime() / 1000
  }
}

const initValueAndStackChart = async () => {
  const chartOptions = {
    rightPriceScale: {
      visible: true,
    },
    leftPriceScale: {
      visible: true,
    },
    layout: {
      textColor: '#DDD',
      background: {
        type: 'solid',
        color: '#222'
      }
    },
    grid: {
      vertLines: { color: '#444' },
      horzLines: { color: '#444' },
    },
  };
  const chart = createChart(document.getElementById('chart-container'), chartOptions);
  const areaSeries = chart.addAreaSeries({
    priceScaleId: 'right',
    lineColor: '#2962FF',
    topColor: '#2962FF',
    bottomColor: 'rgba(41, 98, 255, 0.28)',
  });

  const btcStackAreaSeries = chart.addLineSeries({
    priceScaleId: 'left',
    color: '#f08f1b',
    lineWidth: 4,
  });

  const data = await loadFiatValue();
  const btcStack = await loadBtcStack();

  areaSeries.setData(data);
  btcStackAreaSeries.setData(btcStack);

  chart.timeScale().setVisibleRange(oneYearDateRange());
}


const initCostBasisChart = async () => {
  const chartOptions = {
    rightPriceScale: {
      visible: true,
    },
    leftPriceScale: {
      visible: true,
    },
    layout: {
      textColor: '#DDD',
      background: {
        type: 'solid',
        color: '#222'
      }
    },
    grid: {
      vertLines: { color: '#444' },
      horzLines: { color: '#444' },
    },
  };
  const chart = createChart(document.getElementById('cost-basis-chart-container'), chartOptions);
  const areaSeries = chart.addAreaSeries({
    priceScaleId: 'right',
    lineColor: '#2962FF',
    topColor: '#2962FF',
    bottomColor: 'rgba(41, 98, 255, 0.28)',
  });

  const btcStackAreaSeries = chart.addAreaSeries({
    lineColor: '#2c9a0c',
    topColor: '#2c9a0c',
    bottomColor: 'rgba(44,154,12,0.28)',
  });

  const data = await loadFiatValue();
  const costBasis = await loadCostBasis();

  areaSeries.setData(data);
  btcStackAreaSeries.setData(costBasis);

  chart.timeScale().setVisibleRange(oneYearDateRange());
}

initValueAndStackChart();
initCostBasisChart();
