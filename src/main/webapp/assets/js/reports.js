$(document).ready(function () {
    const textArray = ["Talentify Score", "Talk Ratio", "Win Rate", "Utilization", "Sentiment Score"]
    var box, p_tag;
    let n = 5;
    for (let i = 0; i < 5; i++) {
        box = $("<div></div>");
        p_tag = $("<p></p>").text(textArray[i]);


        $(box).addClass("box" + (i + 1) + "");
        $(box).append(p_tag);

        $('.boxContainer').append(box);
    }


    let year = [];
    let matchCount = [];
    year.push(10, 20, 30, 40, 50, 60, 70,80,90,100);
    matchCount.push(45, 45, 34, 67, 89, 76, 56,60,50,80)
    Highcharts.chart('chart', {
        chart: {
            type: 'column',
            legend: 'false',
        },
        legend:{
            enabled:false
        },
        plotOptions: {
        column: {
            pointPadding: -0.3,
            borderWidth: 0
        }
    },
        title: {
            text: ''
        },
        xAxis: {
            text: null,
            
            categories: year,
            labels: {
                style: {
                    fontSize: '20px',
                    color: 'black'
                },   
            }
        },
        yAxis: {
            text: null,
            labels: {
                style: {
                    fontSize: '20px',
                    color: 'black'
                }
            },
            title:{
                text:null
            }
        },
        credits: {
            enabled: false
        },
        series: [{
            name: null,
            colorByPoint: true,
            data: matchCount,

        }]
    });


    (() => {
        elm = document.getElementById('drop'),
            df = document.createDocumentFragment();
        textArray.forEach(item => {
            option = document.createElement('option');
            option.value = item;
            option.appendChild(document.createTextNode(item));
            df.appendChild(option);
        })
        elm.appendChild(df);
    })();

    (() => {
        rowData = {
            1: ["Team 1", 5, "35%", "46%", "32%", "23%"],
            2: ["Team 2", 5, "35%", "46%", "32%", "23%"],
            3: ["Team 3", 5, "35%", "46%", "32%", "23%"],
            4: ["Team 4", 5, "35%", "46%", "32%", "23%"]
        }
        table = document.getElementById('table')
        for (var key in rowData) {
            // console.log(rowData[key][0])
            tr = document.createElement('tr');
            rowData[key].forEach(item => {
                td = document.createElement('td')
                td.appendChild(document.createTextNode(item));
                tr.appendChild(td);
            })
            table.appendChild(tr)
        }

    })()
});