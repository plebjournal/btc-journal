import { createChart } from 'lightweight-charts';

const loadData = async () => {
  const data = await fetch('/api/fiat-value')
  return data.json();
}

const loadBtcStack = async () => {
  const data = await fetch('/api/portfolio')
  return data.json();
}

const initChart = async () => {
  const chartOptions = {
    rightPriceScale: {
      visible: true,
    },
    leftPriceScale: {
      visible: true,
    },
    layout: {
      textColor: 'black',
      background: {
        type: 'solid',
        color: 'white'
      }
    },
    crosshair: {
      mode: 0
    }
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
    color: '#ffcc00',
    lineWidth: 4,
  });

  const data = await loadData();
  const btcStack = await loadBtcStack();
  areaSeries.setData(data);
  btcStackAreaSeries.setData(btcStack);

  chart.timeScale().fitContent();
}

initChart();

