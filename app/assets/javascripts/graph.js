var data = [
           {date: 1,  exp: 5400,  inc: 8000},
           {date: 2,  exp: 9400,  inc: 8000},
           {date: 3,  exp: 4400,  inc: 8000},
           {date: 4,  exp: 6600,  inc: 8000},
           {date: 5,  exp: 5500,  inc: 9400},
           {date: 6,  exp: 6700,  inc: 8000},
           {date: 7,  exp: 11000, inc: 8000},
           {date: 8,  exp: 5400,  inc: 11500},
           {date: 9,  exp: 5100,  inc: 8000},
           {date: 10, exp: 6400,  inc: 8000},
           {date: 11, exp: 5400,  inc: 8000},
           {date: 12, exp: 7400,  inc: 8000}
           ]

$(function() {
  var margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = 720 - margin.left - margin.right,
      height = 400 - margin.top - margin.bottom;

  var x = d3.scale.linear()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  var expLine = d3.svg.line()
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d.exp); })
      .interpolate("cardinal");

  var incLine = d3.svg.line()
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d.inc); })
      .interpolate("cardinal");

var svg = d3.select("#chart").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(d3.extent(data, function(d) { return d.date; }));
    y.domain([
      d3.min(data, function(d) {
        if (d.inc < d.exp){return d.inc} else {return d.exp}
    }),
      d3.max(data, function(d) {
        if (d.inc > d.exp){return d.inc} else {return d.exp}
    })]);


    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        // .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .attr("dx", 20)
        // .style("text-anchor", "end")
        .text("Dollars ($)");

    svg.append("path")
        .data([data])
        .attr("class", "line1")
        .attr("d", incLine);

    svg.append("path")
        .datum(data)
        .attr("class", "line2")
        .attr("d", expLine);

})
