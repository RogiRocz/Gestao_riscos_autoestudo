AmCharts.makeChart("categorias",
        {
            "type": "pie",
            "angle": 12,
            "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
            "depth3D": 15,
            "colors": [
                "#ff9800","#2196f3","#4caf50","#FCD202","#F8FF01",
                "#B0DE09","#04D215","#0D8ECF","#0D52D1","#2A0CD0",
                "#8A0CCF","#CD0D74","#754DEB","#DDDDDD","#999999",
                "#333333","#000000","#57032A","#CA9726","#990000",
                "#4B0C25"
            ],
            "maxLabelWidth": 200,
            "pullOutDuration": 0,
            "startDuration": 0,
            "startEffect": "easeOutSine",
            "titleField": "category",
            "valueField": "column-1",
            "classNamePrefix": "categoria",
            "decimalSeparator": ",",
            "export": {
                "enabled": true
            },
            "allLabels": [],
            "balloon": {},
            "legend": {
                "enabled": true,
                "align": "center",
                "markerType": "circle"
            },
            "titles": [
                {
                    "id": "Title-1",
                    "size": 15,
                    "text": "Grandes Áreas"
                }
            ],
            "dataProvider": [
                {
                    "category": "Sem Categoria",
                    "column-1": "1"
                },
                {
                    "category": "Infraestrutura",
                    "column-1": "3"
                },
                {
                    "category": "Ensino",
                    "column-1": "2"
                }
            ]
        },
    );

AmCharts.makeChart("categorias2",
    {
        "type": "pie",
        "angle": 12,
        "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
        "depth3D": 15,
        "titleField": "Nivel de risco",
        "valueField": "Valor",
        "pullOutDuration": 0,
        "startDuration": 0,
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "align": "center",
            "markerType": "circle"
        },
        "titles": [
            {
                "id": "Title-1",
                "size": 15,
                "text": "Nivel de Risco"
            }
        ],
        "dataProvider": [
            {
                "Nivel de risco": "Muito Alto",
                "Valor": "1"
            },
            {
                "Nivel de risco": "Alto",
                "Valor": "1"
            },
            {
                "Nivel de risco": "Medio",
                "Valor": "1"
            },
            {
                "Nivel de risco": "Baixo",
                "Valor": "1"
            },
            {
                "Nivel de risco": "Insignificante",
                "Valor": "1"
            }
        ]
    }
);

AmCharts.makeChart("nivelDeRisco",
    {
        "type": "serial",
        "categoryField": "category",
        "angle": 30,
        "depth3D": 30,
        "colors": [
            "#4caf50",
            "#388e3c",
            "#ffc107",
            "#f44336",
            "#2A0CD0",
            "#CD0D74",
            "#CC0000",
            "#00CC00",
            "#0000CC",
            "#DDDDDD",
            "#999999",
            "#333333",
            "#990000"
        ],
        "startDuration": 1,
        "categoryAxis": {
            "gridPosition": "start"
        },
        "trendLines": [],
        "graphs": [
            {
                "balloonText": "[[title]]: [[value]]",
                "fillAlphas": 1,
                "id": "AmGraph-1",
                "title": "Riscos Aceitaveis",
                "type": "column",
                "valueField": "column-1"
            },
            {
                "balloonText": "[[title]]: [[value]]",
                "fillAlphas": 1,
                "id": "AmGraph-2",
                "title": "Riscos Aceitaveis com Restriçoes",
                "type": "column",
                "valueField": "column-2"
            },
            {
                "balloonText": "[[title]]: [[value]]",
                "fillAlphas": 1,
                "id": "AmGraph-3",
                "title": "Riscos Críticos",
                "type": "column",
                "valueField": "column-3"
            },
            {
                "balloonText": "[[title]]: [[value]]",
                "fillAlphas": 1,
                "id": "AmGraph-4",
                "title": "Riscos Inaceitaveis",
                "type": "column",
                "valueField": "column-4"
            }
        ],
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "title": "Quantidade"
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "useGraphSettings": true
        },
        "titles": [],
        "dataProvider": [
            {
                "category": "Nivel de risco",
                "column-1": "23",
                "column-2": "33",
                "column-3": "43",
                "column-4": "126"
            }
        ]
    }
);

AmCharts.makeChart("incidencia",
    {
        "type": "serial",
        "categoryField": "date",
        "dataDateFormat": "YYYY-MM",
        "colors": [
            "#f44336",
            "#4caf50",
            "#B0DE09",
            "#0D8ECF",
            "#2A0CD0",
            "#CD0D74",
            "#CC0000",
            "#00CC00",
            "#0000CC",
            "#DDDDDD",
            "#999999",
            "#333333",
            "#990000"
        ],
        "theme": "default",
        "categoryAxis": {
            "minPeriod": "MM",
            "parseDates": true
        },
        "chartCursor": {
            "enabled": true,
            "categoryBalloonDateFormat": "MMM YYYY",
            "cursorColor": "#2196F3"
        },
        "chartScrollbar": {
            "enabled": true
        },
        "trendLines": [],
        "graphs": [
            {
                "balloonText": "[[value]] incidências em ameaças",
                "bullet": "round",
                "id": "AmGraph-1",
                "title": "Ameaças",
                "valueField": "column-1"
            },
            {
                "balloonText": "[[value]] incidências em oportunidades",
                "bullet": "square",
                "id": "AmGraph-2",
                "title": "Oportunidades",
                "valueField": "column-2"
            }
        ],
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "title": "Quantidade"
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "useGraphSettings": true
        },
        "titles": [
            {
                "id": "Title-1",
                "size": 15,
                "text": ""
            }
        ],
        "dataProvider": [
            {
                "date": "2017-01",
                "column-1": 8,
                "column-2": 5
            },
            {
                "date": "2017-02",
                "column-1": 6,
                "column-2": 7
            },
            {
                "date": "2017-03",
                "column-1": 2,
                "column-2": 3
            },
            {
                "date": "2017-04",
                "column-1": 1,
                "column-2": 3
            },
            {
                "date": "2017-05",
                "column-1": 2,
                "column-2": 1
            },
            {
                "date": "2017-06",
                "column-1": 3,
                "column-2": 2
            },
            {
                "date": "2017-07",
                "column-1": 6,
                "column-2": 8
            },
            {
                "date": "2017-08",
                "column-1": 4,
                "column-2": 6
            },
            {
                "date": "2017-09",
                "column-1": 2,
                "column-2": 3
            },
            {
                "date": "2017-10",
                "column-1": 4,
                "column-2": 4
            },
            {
                "date": "2017-11",
                "column-1": 8,
                "column-2": 5
            },
            {
                "date": "2017-12",
                "column-1": 2,
                "column-2": 4
            }
        ]
    }
);