# tableau-intro-with-trees
Intro workshop to Tableau Public for Chicago Data Viz Community. Let's look at Chicago's trees!

## What this workshop will cover
- Tableau products, what they're useful for and how they compare to other data viz / BI tools
- Prepping data for Tableau
- Constructing dashboards
- Filtering data
- Maps
- Tooltips

## Why trees?
My passion is studying how the built environment impacts human health. Trees, which are amazing in nature, are integrally tied to the built environment in urban areas and have major impacts on our health. Learn more:

- [Urban nature for health and wellbeing](http://www.vibrantcitieslab.com/resources/urban-nature-for-human-health-and-well-being/), U.S. Forest Service, February 2018
- [Funding trees for health](https://global.nature.org/content/funding-trees-for-health), The Nature Conservancy, September 2017
- [Why public health researchers are looking to urban trees](https://www.smithsonianmag.com/science-nature/why-public-health-researchers-are-looking-urban-trees-180960985/#oYT9cIpAYipFIF3Q.99), Smithsonian Magazine, November 2016
- [The health benefits of trees](https://www.theatlantic.com/health/archive/2014/07/trees-good/375129/), The Atlantic, July 2014

## Let's get started!

### Download Tableau Public and import data

1. Download the latest version of [Tableau Public](https://public.tableau.com/en-us/s/) for Windows or Mac. This should be version 2018.3.2. Once downloaded, open the program.
2. Fork this GitHub repo and save `potentialCanopy.csv` in an accessible place. Alternatively, [copy the data](https://github.com/NicMoe/tableau-intro-with-trees/blob/master/potentialCanopy.csv) directly into a spreadsheet and save that document as `potentialCanopy.csv`.
3. In Tableau Public, on the left side of the screen there are file and server types listed that you can connect to. Select 'Text file' and navigate to where you saved the `potentialCanopy.csv` file.
4. A data preview will show you how Tableau is reading your data file. Do the field types look correct? Does the displayed data look right? Let's change the 'Town' field from a 'string' to the geographic role of 'city'.

   Above 'Town', click on the blue 'Abc'.

   Mouse over 'Geographic Role' and select 'City'.

5. On the lower left side of the window there are several tabs. Click `Sheet 1`.
6. What all do we see here?

   Distinction between dimensions and measures

   Run through all the top pull downs
   
   Sheet, dashboard, and story

### Create first worksheet

This sheet will help us recreate the 'Plantable Space Percentage' charts that CRTI included for each Chicago area municipality on their '[Urban Forest Canopy Summary](http://chicagorti.org/CanopySummaries)' documents (on page 4 for most of these PDF's).

7. On the upper right is a tab with a chart icon that says 'Show Me'. Click this icon to reveal common chart types available for you to build and what minimum data requirements exist for each.
8. We want a 'Stacked Bar' chart, so we need at least one 'Dimension' and at least one 'Measure'. The chart we are trying to reproduce has land use on the x-axis (columns) and stacks acreage estimates for each along the y-axis (rows).

   From under 'Dimensions' on the left panel, drag 'Land Use' just to the right of 'Columns' in the upper middle portion of the middle panel.

   From under 'Measures', drag 'Acres' to the right of 'Rows'.

   To distinguish acreage by canopy suitability, from under 'Dimensions' drag 'Status' on top of 'Color' in the 'Marks' box.

9. Let's fix the colors and the ordering of the canopy suitability status to resemble the static [PDF](http://chicagorti.org/CanopySummaries) charts.

   Click on 'Color' in the 'Marks' box. Click 'Edit Colors…' in the pop-up box: the hex codes used in the [PDF](http://chicagorti.org/CanopySummaries)'s are `#dddddd` for 'Unsuitable', `#aed000` for 'Plantable', and `#006600` for 'Canopy'. Click 'OK'.

   To change the ordering to match the chart, mouseover the blue 'Status' within the 'Marks' box and click on the down arrow. Click 'Sort…', sort by 'Manual sort', and modify to reflect [PDF](http://chicagorti.org/CanopySummaries) chart order ('Unsuitable' on top, 'Canopy' on bottom).

10. Add a filter. Drag 'Town' (under 'Dimensions') into the 'Filters' box. In the pop-up, select the 'Use all' or 'All' button, and click 'OK'. This filter will come into play once we create a dashboard.
11. Create a calculated field for use in a tooltip.

   Under the 'Analysis' dropdown, select 'Create calculated field…'.

   In the popup, name it `Square Miles`.

   In the box, type `[Acres] / 640`, then click 'OK'. A variable called 'Square Miles' should appear in the 'Measures' box in the left panel.

12. Edit the tooltip.

   To the 'Tooltip' icon in the 'Marks' box in the middle of your screen, drag both 'Town' from 'Dimensions' and 'Square Miles' from 'Measures'. They should appear at the bottom of the 'Marks' box as `ATTR(Town)` and `SUM(Square ..`.

   Now, click the 'Tooltip' icon and a popup will appear. Edit it to create a sentence structure: `In <ATTR(Town)>, there are <SUM(Acres)> acres (<SUM(Square Miles)> square miles) of <Status> land within areas designated as <Land Use> land use.`

13. Eliminate titles from sheet.

   Toward the top of your sheet, it should be labelled `Sheet 1`. Right click that and select 'Hide label'.

   Do the same with the smaller column label that says 'Land use'.

14. On the lower left, right-click the `Sheet 1` tab and click 'Rename'. Type `Plantable Space Percentage`.

### Create map

Tableau has rolled out some geographic mapping capabilities in the last few years. Let's see how tree canopy potential varies across the Chicago metropolitan area.

15. On the lower left, just to the right of the `Plantable Space Percentage` tab, there's an icon that includes a styled bar chart and a plus sign. Click that icon to create a new worksheet.
16. From under 'Dimensions' on the left panel, drag 'Town' just to the middle of the center panel. It may take a few seconds to associate the field data to pre-loaded location data.
17. Notice that there are now blue dots placed over a map of the central United States. Most of the dots are near Chicago, but there are a few appearing in far-flung states because our 'Town' field doesn't specify which state this data set is from so Tableau is doing the best it can to guess. Let's remove the outlying data points for now, as they aren't really going to work for our map.

   In Minnesota, there is a blue dot called 'ForestLake'. Right click it and 'Exclude' it from the map. Note that the data rows for 'ForestLake' are not deleted, just removed for this worksheet.

   On the upper left corner of your map, there is a right-pointing arrow icon. Click that and select the 'Pan' icon (four connected arrows pointing to the cardinal directions). Move around to Texas to exclude 'Knollwood' and to New York to exclude 'Chemung'.

18. Pan over to Chicago and zoom in so you can see all the dots over Chicago area communities. You'll notice that not all communities were appropriately associated with the map since their names are two generic and Tableau didn't know where to place them (sorry, Plainfield). Fortunately, we still retain about half the towns which should be enough for some geographic exploration.

   On the lower right corner of your map, you'll see '161 unknown' - these are the communities with generic names. Click that button and in the pop-up, select 'Filter data' to tell Tableau to ignore these locations.

19. Add a couple of filters that will come into play once we create a dashboard.

   Drag 'Status' (under 'Dimensions') into the 'Filters' box. In the pop-up, select just 'plantable', and click 'OK'.

   Drag 'Land Use' (under 'Dimensions') into the 'Filters' box. In the pop-up, select the 'Use all' or 'All' button, and click 'OK'. In the 'Filters' box, right-click 'Land Use' and select 'Show Filter'. This way users will be able to choose land use types will influence the color and size of each dot.
   
20. Add some meaningful color. Drag 'Acres' (under 'Measures') over the 'Colors' icon in the 'Marks' box. Edit the colors to better see how much canopy availability differs by community. This will keep the focus on where there is potential land to plant trees.

   Click the 'Color' icon in the 'Marks' box, then click the 'Edit Colors...' button.

   In the pop-up, from the 'Palette' pulldown, choose 'Temperature Diverging'. Select the 'Reversed' checkbox and the 'Use Full Color Range' checkbox.

   From the lower right of the pop-up, click the 'Advanced >>' button. Select the 'Center:" checkbox and type `10,000`. 

21. On the lower left, right-click the `Sheet 2` tab and click 'Rename'. Type `Plantable Acreage by Community`.

### Create dashboard

22. On the lower left, just to the right of your two worksheet tabs, there are three icons. Click the middle icon, which includes a 2x2 grid and a plus sign, to create a new dashboard.
23. Notice that for dashboards the left panel has different components than you saw previously for the worksheets.
24. Add your two worksheets to this dashboard.

   From the left-hand panel, under 'Sheets', drag `Plantable Space Percentage` to the center where it says 'Drop sheets here'.

   From the same place, drag `Plantable Acreage by Community` to the very bottom of the center panel, over the newly placed bar chart.

25. Define that you want to filter the dashboard by community.

   Click on the map, and notice to the upper right of the map there are now several icons including a funnel-shaped filter icon. Click it.
   
   Test the filter by clicking one of the dots on the map. It should gray-out all the other dots and filter the top bar chart so you can see plantable space percentage by land use type for just that community.
   
26. Drag the 'Land Use' filter list to the right side of the map. Then, drag the 'Acres' legend component to below the 'Land Use' filter.

## Save your dashboard to the interwebs

27. Under 'File', select 'Save to Tableau Public as...'

28. Sign into your Tableau Public account.

29. It may take a few minutes to upload your dashboard to the server, but once there it will have a unique URL that you can share.


## Tree data origin
There were a few data sources I considered for this workshop:

- Chicago Region Trees Initiative has their [Municipal Canopy Summary](http://chicagorti.org/CanopySummaries) which covers each municipality in the 7-county area, plus parts of Chicago. It includes estimates for percent of land covered by trees, broken down by general land uses, as well as estimates of plantable space. Thanks to Lindsay Darling with the Morton Arboretum, this is the data set I selected for this workshop, which can be found [here](https://github.com/NicMoe/tableau-intro-with-trees/blob/master/potentialCanopy.csv)
- The USDA Forest Service has data on tree Censuses conducted within the [City of Chicago in 2007](https://www.nrs.fs.fed.us/data/urban/state/city/?city=15) and the [7-county region in 2010](https://www.nrs.fs.fed.us/data/urban/state/city/?city=26). These data sets contain count estimates by tree species, estimates of their estimates of their carbon impact, and economic value. There are also estimates of canopy cover to parasite susceptibility, by type of parasite and land use.
