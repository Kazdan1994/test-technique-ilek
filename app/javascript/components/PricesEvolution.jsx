import React from "react";
import { Chart as ChartJS, registerables } from "chart.js";
import { Line } from "react-chartjs-2";

ChartJS.register(...registerables);

const PricesEvolution = () => {
  const data = {
    labels: [
      "2015-02-01",
      "2015-10-08",
      "2017-03-20",
      "2017-11-15",
      "2018-04-19",
      "2019-01-15",
      "2021-02-23",
      "2022-02-11",
      "2022-09-23",
      "2023-01-11",
    ],
    datasets: [
      {
        label: "Price Evolution",
        data: [11108, 7241, 8247, 2301, 2524, 6857, 11793, 10403, 13254, 4474],
        fill: false,
        borderColor: "rgb(75, 192, 192)",
        tension: 0.1,
      },
    ],
  };

  const options = {
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  };

  return <Line data={data} options={options} />;
};

export default PricesEvolution;
