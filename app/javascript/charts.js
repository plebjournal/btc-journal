import { createChart } from 'lightweight-charts';

const loadData = async () => {
  const data = await fetch('/api/fiat-value')
  return data.json();
}

const initChart = async () => {
  const chartOptions = { layout: { textColor: 'black', background: { type: 'solid', color: 'white' } } };
  const chart = createChart(document.getElementById('chart-container'), chartOptions);
  const areaSeries = chart.addAreaSeries({
    lineColor: '#2962FF', topColor: '#2962FF',
    bottomColor: 'rgba(41, 98, 255, 0.28)',
  });
  const data = await loadData();
  areaSeries.setData(data);

  chart.timeScale().fitContent();
}

initChart();

