export let basicData = {
    chart: {
        type: "line"
      },
      //colors: ["#38761d", "#f1c232", "#ff9900", "#cc0000"],
      title: {
        text: ""
      },
      /*subtitle: {
        text:
          'Source: <a href="https://en.wikipedia.org/wiki/World_population">Wikipedia.org</a>'
      },*/
      xAxis: {
        categories: ["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov",
        "dez"],
        title: {
          text: "Mês"
        }
      },
      yAxis: {
        min: 0,
        title: {
          text: "Quantidade", 
          align: "middle"
        },
        labels: {
          overflow: "justify"
        },
        allowDecimals: false
      },
      tooltip: {
        valueSuffix: ""
      },
      plotOptions: {
        line: {
          dataLabels: {
            enabled: true
          }
        }
      },
      legend: {
        layout: "vertical",
        align: "right",
        verticalAlign: "top",
        x: -40,
        y: 80,
        floating: true,
        borderWidth: 1,
        backgroundColor:
          "#FFFFFF",
        shadow: true
      },
      credits: {
        enabled: false
      },
      series: [
          
      ],
      responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }
};





  