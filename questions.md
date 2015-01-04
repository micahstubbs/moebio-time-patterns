Q Some companies have fiscal years that do not end on 12/31.  How should I represent those partial years?

A For now, I will bin the data by the year the financials were reported.  So a company that reports financials on 6/30/2012 would be grouped with the 2012 year, even though half of the activity described by the financials occurred in the 2011 year.  

Q How can layout the tooltip it is not obscured by points below it? A force layout?

Q What is the best way to ensure that dots do not overlap the axis?  Play with scales?  Translate the axis away from the dots?  Something else?

code example:

  // don't want dots overlapping axis, so add in buffer to data domain
  // buffer defined as a constant value '1'
  xScale.domain(
    [
    d3.min(data, xValue)-1, 
    d3.max(data, xValue)+1
    ]);
  
  // buffer now scaled to min of data
  yScale.domain(
    [
      d3.min(data, yValue)-.01*d3.min(data, yValue), 
      d3.max(data, yValue)+.01*d3.max(data, yValue)
    ]);

