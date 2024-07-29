import { createChart } from 'lightweight-charts';

const loadData = async () => {
  const data = await fetch('/api/fiat-value')
  return data.json();
}

const oneYearDateRange = () => {
  const currentDate = new Date()
  return {
    from: new Date(currentDate.getFullYear() - 1, currentDate.getMonth(), currentDate.getDay()).getTime() / 1000,
    to: currentDate.getTime() / 1000
  }
}

const initChart = async () => {
  const chartOptions = {
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
    lineColor: '#2962FF',
    topColor: '#2962FF',
    bottomColor: 'rgba(41, 98, 255, 0.28)',
  });
  const data = await loadData();
  areaSeries.setData(data);


  chart.timeScale().setVisibleRange(oneYearDateRange())
}

initChart();

