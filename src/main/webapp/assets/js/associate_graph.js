$(document).ready(function () {
    var chart = Highcharts.chart('graph', {
        chart: {
            type: 'column',
            inverted: true,
            backgroundColor: 'rgb(248, 248, 248)',
            borderRadius: '10px',
            border: '1px solid rgb(218, 216, 216)',
        },

        credits: null,
        title: {
            text: '',
            style: {
                display: 'none'
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.05,
                borderWidth: 0
            }
        },
        legend: {
            align: 'right',
            verticalAlign: 'middle',
            layout: 'vertical',
            itemStyle: {
                fontSize: '17px',
            },
            symbolRadius: 0,
            display: 'none'
        },
        xAxis: {
            categories: ['Appointment', 'Unique Sales Proposition', 'Qualification',
                'Primary Interest', 'Question', 'Brand', 'Value Proposition', 'Choice'
            ],
            title: null,
            labels: {
                x: -10,
                style: {
                    fontSize: '15px',
                },
                title: null
            },

        },
        yAxis: {
            allowDecimals: false,
            title: null,
            labels: {
                y: 25,
                style: {
                    fontSize: '15px',
                },
                title: null,
            },

        },
        series: [{
            name: 'Success All',
            data: [10, 15, 13, 21, 25, 22, 10, 20],
            color: '#50AF49',

        }, {
            name: 'Call Task',
            data: [26, 20, 16, 10, 23, 13, 25, 10],
            color: '#076DCE'
        }],
    });
})
let status = true
popup = () => {
    if (status) {
        document.getElementsByClassName("popup")[0].style = "display:block";
        // $('.blur-container').addClass("blur");
        document.getElementsByClassName("blur-container")[0].style="display:block"
        status = false;

    } else {
        document.getElementsByClassName("popup")[0].style = "display:none";
        document.getElementsByClassName("blur-container")[0].style="display:none"

        status = true;
    }
}
closePopup = () => {
    console.log("close()")
    document.getElementsByClassName("popup")[0].style = "display:none";
    document.getElementsByClassName("blur-container")[0].style="display:none"

    status = true;
}