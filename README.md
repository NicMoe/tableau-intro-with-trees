# tableau-intro-with-trees
Intro workshop to Tableau Public for Chicago Data Viz Community. Let's look at Chicago's trees!

## What this workshop will cover
- Tableau products, what they're useful for and how they compare to other data viz / BI tools
- Prepping data for Tableau
- Constructing dashboards
- Filtering data
- Maps
- Tooltips

## First steps
1. Download the latest version of [Tableau Public](https://public.tableau.com/en-us/s/) for Windows or Mac. This should be version 2018.3.2. Once downloaded, open the program.
2. Fork this GitHub repo and save `potentialCanopy.csv` in an accessible place. Alternatively, [copy the data](https://raw.githubusercontent.com/NicMoe/tableau-intro-with-trees/master/potentialCanopy.csv) and save that document as `potentialCanopy.csv`.
3. Join the Chicago Data Viz Community [Slack](https://bit.ly/ChiDataVizSlackInvite)!
4. Take the Chicago Data Viz Community [Survey](https://bit.ly/ChiDataVizSurvey)!

## Why trees?
My passion is studying how the built environment impacts human health. Trees, which are amazing in nature, are integrally tied to the built environment in urban areas and have major impacts on our health. I've got a whole Facebook page dedicated to this topic called [Well Placed](https://www.facebook.com/WellPlacedPage/). Learn more about trees and health:

- [The health benefits of trees](https://www.theatlantic.com/health/archive/2014/07/trees-good/375129/), The Atlantic, July 2014
- [Why public health researchers are looking to urban trees](https://www.smithsonianmag.com/science-nature/why-public-health-researchers-are-looking-urban-trees-180960985/#oYT9cIpAYipFIF3Q.99), Smithsonian Magazine, November 2016
- [Funding trees for health](https://global.nature.org/content/funding-trees-for-health), The Nature Conservancy, September 2017
- [Urban nature for health and wellbeing](http://www.vibrantcitieslab.com/resources/urban-nature-for-human-health-and-well-being/), U.S. Forest Service, February 2018
- [Why Detroit residents pushed back against tree-planting](https://www.citylab.com/environment/2019/01/detroit-tree-planting-programs-white-environmentalism-research/579937/), CityLab, January 2019

## A few notes about Tableau Public

1. Tableau has [several products](https://www.tableau.com/products), from large-scale enterprise solutions down to freeware Tableau Public. A major difference between the enterprise solution versus the free version is that with the free Tableau Public, **you must save your workbook online and any data you use will be publically accessible**. Registered [nonprofit organizations](https://www.tableau.com/foundation/license-donations) and [students](https://www.tableau.com/academic/students) are permitted free licenses for Tableau's more secure products.

2. Tableau offers excellent data exploration and visualization ability compared to Excel's charts and pivot tables. As well, it is quicker to learn than more flexible tools such as R's ggplot2 or D3.js.

3. Tableau is super ornery about data structure. Its worksheets can only handle data presented in long-format tables and doesn't know what to do with wide-format data. I would recommend [reshaping your data](https://www.youtube.com/watch?v=R1WsOmM_grU) into long-format using Excel, R, or any appropriate tool of your choice prior to importing anything into Tableau. For this workshop, I took human-readable wide format tables and restructured them into one long-format table using R. The code can be found in this GitHub repo.

4. Note that there is no standard version control for Tableau. If you need to retain an old version of a workbook, make sure to save any new version using a unique name to avoid any overwrite.

## Let's get started!

### Open Tableau Public and import data

1. In Tableau Public, on the left side of the screen there are file and server types listed that you can connect to. Select 'Text file' and navigate to where you saved the `potentialCanopy.csv` file.
2. A data preview will show you how Tableau is reading your data file. Do the field types look correct? Does the displayed data look right? Let's change the 'Town' field from a 'string' to the geographic role of 'city' so it will be ready to map later.

   Above 'Town', click on the blue 'Abc'.

   Mouse over 'Geographic Role' and select 'City'.

3. On the lower left side of the window there are several tabs. Click `Sheet 1`.
4. What all do we see here?

   On the left panel we see your variables distinguished as 'dimensions', which are usually categorical and Tableau assumes are independent variables, versus 'measures', which are always numerical and Tableau perceives as dependent variables.

   Familiarize yourself with all the pull down options in the title bar: 'File', 'Data', 'Worksheet', etc.
   
   There are three small icons on the bottom left: 'worksheet' is a space to set up a single chart or table; a 'dashboard' is a space to combine multiple worksheets into a single interface; and 'story' is a series of dashboards that can be used like an interactive presentation. We will begin your project with an initial worksheet.

### Create first worksheet

This sheet will help us recreate the 'Plantable Space Percentage' charts that CRTI included for each Chicago area municipality on their '[Urban Forest Canopy Summary](http://chicagorti.org/CanopySummaries)' documents (on page 4 for most of these PDF's).

5. On the upper right is a tab with a chart icon that says 'Show Me'. Click this icon to reveal common chart types available for you to build and what minimum data requirements exist for each. Click 'Show Me' again to hide it and get it out of the way.
6. We want a 'Stacked Bar' chart, so we need at least one 'Dimension' and at least one 'Measure'. The chart we are trying to reproduce has land use on the x-axis (columns) and stacks acreage estimates for each along the y-axis (rows).

   From under 'Dimensions' on the left panel, drag 'Land Use' just to the right of 'Columns' in the upper middle portion of the middle panel.

   From under 'Measures', drag 'Acres' to the right of 'Rows'. At this point a bar chart should appear in the center frame.

   To distinguish acreage by canopy suitability, from under 'Dimensions' drag 'Status' on top of 'Color' in the 'Marks' box.

7. Let's fix the colors and the ordering of the canopy suitability status to resemble the static [PDF](http://chicagorti.org/CanopySummaries) charts.

   Click on 'Color' in the 'Marks' box. Click 'Edit Colors…' in the pop-up box, and one-by-one double-click each ccategory you want to change the color of: the hex codes used in the [PDF](http://chicagorti.org/CanopySummaries)'s are `#dddddd` for 'Unsuitable', `#aed000` for 'Plantable', and `#006600` for 'Canopy'. For Mac users, you will need to choose the second tab within the 'Colors' pop-up, select 'RGB Sliders' in the dropdown, and input hex color values in the appropriate box. Click 'OK', and set the correct color for all three categories.

   To change the ordering to match the chart, mouseover the blue 'Status' within the 'Marks' box and click on the down arrow. Click 'Sort…', sort by 'Manual sort', and modify to reflect [PDF](http://chicagorti.org/CanopySummaries) chart order ('Unsuitable' on top, 'Canopy' on bottom).

8. Add a filter. Drag 'Town' (under 'Dimensions') into the 'Filters' box. In the pop-up, select the 'Use all' or 'All' button, and click 'OK' for Windows or the red X for Mac. This filter will come into play once we create a dashboard.
9. Create a calculated field for use in a tooltip.

   Under the 'Analysis' dropdown, select 'Create calculated field…'.

   In the popup, name it `Square Miles`.

   In the white space, type `[Acres] / 640`, then click 'OK'. A variable called 'Square Miles' should appear in the 'Measures' box in the left panel.

10. Edit the tooltip.

   Towards the 'Tooltip' icon in the 'Marks' box in the middle of your screen, drag both 'Town' from 'Dimensions' and 'Square Miles' from 'Measures', one at a time. They should appear at the bottom of the 'Marks' box as `ATTR(Town)` and `SUM(Square ..`.

   Now, click the 'Tooltip' icon and a popup will appear. Edit it to create a sentence structure: `In <ATTR(Town)>, there are <SUM(Acres)> acres (<SUM(Square Miles)> square miles) of <Status> land within areas designated as <Land Use> land use.`
   
   Mouseover one of the bars in the bar chart and make sure the tooltip makes sense. Because all towns are included in the current selection, it should begin as 'In \*, there are..." The asterisk will later be replaced by the name of the selected community.

11. Eliminate titles from sheet.

   Toward the top of your sheet, it should be labelled `Sheet 1`. Right click that and select 'Hide title'.

   Do the same with the smaller column label that says 'Land use'.

12. On the lower left, right-click the `Sheet 1` tab and click 'Rename'. Type `Plantable Space Percentage`.

### Create map

Tableau has rolled out some great geographic mapping capabilities in the last few years. Let's see how tree canopy potential varies across the Chicago metropolitan area.

13. On the lower left, just to the right of the `Plantable Space Percentage` tab, there's an icon that includes a tiny bar chart and a plus sign. Click that icon to create a new worksheet.
14. From under 'Dimensions' on the left panel, drag 'Town' to the middle of the center panel. It may take a few seconds to associate the field data to pre-loaded location data.
15. Notice that there are now blue dots placed over a map of the central United States. Most of the dots are near Chicago, but there are a few appearing in far-flung states because our 'Town' field doesn't specify which state this data set comes from, so Tableau does the best it can to guess. Let's remove the outlying data points for now, as they aren't really going to work for our map.

   In Minnesota, there is a blue dot called 'ForestLake'. Right click it and 'Exclude' it from the map. Note that the data rows for 'ForestLake' are not deleted, just removed for this worksheet.

   On the upper left corner of your map, there is a right-pointing arrow icon. Click that and select the 'Pan' icon (four connected arrows pointing to the cardinal directions). Move around to Texas to exclude 'Knollwood' and to New York to exclude 'Chemung'.

16. Pan over to Chicago and zoom in so you can see all the dots over Chicago area communities. You'll notice that not all communities were appropriately associated with the map since their names are too generic and Tableau didn't know where to place them (sorry, Plainfield). Fortunately, we still retain about half the towns which should be enough for some geographic exploration.

   On the lower right corner of your map, you'll see '161 unknown' - these are the communities with generic names. Click that button and in the pop-up, select 'Filter data' to tell Tableau to ignore these locations.

17. Add a couple of filters for our dashboard.

   Drag 'Status' (under 'Dimensions') into the 'Filters' box. In the pop-up, select just 'plantable', and click 'OK'.

   Drag 'Land Use' (under 'Dimensions') into the 'Filters' box. In the pop-up, select the 'Use all' or 'All' button, and click 'OK'. In the 'Filters' box, right-click 'Land Use' and select 'Show Filter'. Will this filter, user-selected land use types will influence the color and size of each dot.
   
18. Add some meaningful color. Drag 'Acres' (under 'Measures') over the 'Color' icon in the 'Marks' box. Edit the colors to better see how much canopy availability differs by community. This will keep the focus on where there is potential land to plant trees.

   Click the 'Color' icon in the 'Marks' box, then click the 'Edit Colors...' button.

   In the pop-up, from the 'Palette' pulldown, choose 'Temperature Diverging' from near the bottom of the list. Select the 'Reversed' checkbox and the 'Use Full Color Range' checkbox.

   From the lower right of the pop-up, click the 'Advanced >>' button. Select the 'Center:" checkbox and type `640`. This number will make sure Chicago doesn't visually overshadow its smaller neighbors.

19. Change the dot sizes to reflect acreage of plantable space in each community, by land use type. To do so, drag 'Acres' (under 'Measures') over the 'Size' icon in the 'Marks' box.

20. On the lower left, right-click the `Sheet 2` tab and click 'Rename'. Type `Plantable Acreage by Community`.

### Create dashboard

21. On the lower left, just to the right of your two worksheet tabs, there are three small icons. Click the middle icon, which includes a tiny 2x2 grid and a plus sign, to create a new dashboard.
22. Notice that for dashboards the left panel has different components than you saw previously for the worksheets. One of these is 'Size'.

   Click the dropdown under 'Size' and select 'Automatic'. For now this should make the dashboard take up as much space as it needs.
   
23. Add your two worksheets to this dashboard.

   From the left-hand panel, under 'Sheets', drag `Plantable Space Percentage` to the center where it says 'Drop sheets here'.

   From the same place, drag `Plantable Acreage by Community` to the left side of the center panel, over the newly placed bar chart. When the left half of the bar chart is grayed out, release to drop your map there.

24. Define that you want to filter the dashboard by community.

   Click on the map, and notice to the upper right of the map there are now several icons including a funnel-shaped filter icon. Click it.
   
   Test the filter by clicking one of the dots on the map. It should gray-out all the other dots and filter the bar chart so you can see plantable space percentage by land use type for just that community.
   
25. If you mouse over one of the bars in the bar chart, notice that the tooltip now gives information specific to the selected community. As well, click '(All)' in the 'Land Use' filter to deselect each land use type, then one-by-one see how each checkbox influences the map. Where has the most canopy potential for cemetary land? What about for golf zoned areas?

### Save your dashboard to the interwebs

26. Under 'File', select 'Save to Tableau Public as...'.

27. Sign into your Tableau Public account. To avoid overwriting a previous version, make sure to give the new version of your workbook a unique name.

28. It may take a few minutes to upload your dashboard to the server, but once there it will have a unique URL that you can share.

## Keep learning
Check out Tableau's [Viz of the Day Gallery](https://public.tableau.com/en-us/s/gallery) which shows some spectacular uses of Tableau Public. The coolest part of all Tableau Public workbooks is that they are downloadable (via the lower right-hand download icon on every Tableau Public dashboard) allowing you to see how users structured their data as well as their worksheets, dashboards, and stories.

## Tree data origin
There were a few data sources I considered for this workshop:

- Chicago Region Trees Initiative has their [Municipal Canopy Summary](http://chicagorti.org/CanopySummaries) which covers each municipality in the 7-county area, plus parts of Chicago. It includes estimates for percent of land covered by trees, broken down by general land uses, as well as estimates of plantable space. Thanks to Lindsay Darling with the Morton Arboretum, this is the data set I selected for this workshop, which can be found [here](https://github.com/NicMoe/tableau-intro-with-trees/blob/master/potentialCanopy.csv).
- The USDA Forest Service has data on tree Censuses conducted within the [City of Chicago in 2007](https://www.nrs.fs.fed.us/data/urban/state/city/?city=15) and the [7-county region in 2010](https://www.nrs.fs.fed.us/data/urban/state/city/?city=26). These data sets contain count estimates by tree species, estimates of their estimates of their carbon impact, and economic value. There are also estimates of canopy cover to parasite susceptibility, by type of parasite and land use.
