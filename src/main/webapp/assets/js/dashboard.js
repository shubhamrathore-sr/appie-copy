$(document).ready(function () {
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    
    // Draw the chart and set the chart values
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
      ['', 'Hours per Day'],
      ['', 8],
      ['', 2],
      ['', 4],
      ['', 2],
      ['', 8]
    ]);
    
      var options = { legend: 'none','width':50, 'height':40};
    
      // var chart = new google.visualization.PieChart(document.getElementById('piechart'));
      // chart.draw(data,options);
    }
})