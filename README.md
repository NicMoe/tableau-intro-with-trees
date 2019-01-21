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

### Create first sheet

This sheet will help us recreate the 'Plantable Space Percentage' charts that CRTI included for each Chicago area municipality on their '[Urban Forest Canopy Summary](http://chicagorti.org/CanopySummaries)' documents (on page 4 for most of these PDF's).

7. On the upper right is a tab with a chart icon that says 'Show Me'. Open this to reveal common chart types available for you to build and what minimum data requirements exist for each.
8. We want a 'Stacked Bar' chart, so we need at least one 'Dimension' and at least one 'Measure'. The chart we are trying to reproduce has land use on the x-axis (columns) and stacks acreage estimates for each along the y-axis (rows).

   From under 'Dimensions' on the left panel, drag 'Land Use' just to the right of 'Columns' in the upper middle portion of the middle panel.

   From under 'Measures', drag 'Acres' to the right of 'Rows'.

   To distinguish acreage by canopy suitability, from under 'Dimensions' drag 'Status' on top of 'Color' in the 'Marks' box.

9. Let's fix the colors and the ordering of the canopy suitability status to resemble the static [PDF](http://chicagorti.org/CanopySummaries) charts.

   Click on 'Color' in the 'Marks' box. Click 'Edit Colors…' in the pop-up box: the hex codes used in the [PDF](http://chicagorti.org/CanopySummaries)'s are `#dddddd` for 'Unsuitable', `#aed000` for 'Plantable', and `#006600` for 'Canopy'. Click 'OK'.

   To change the ordering to match the chart, mouseover the blue 'Status' within the 'Marks' box and click on the down arrow. Click 'Sort…', sort by 'Manual sort', and modify to reflect [PDF](http://chicagorti.org/CanopySummaries) charts ('Unsuitable' on top, 'Canopy' on bottom).

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


## Tree data origin
There were a few data sources I considered for this workshop:

- Chicago Region Trees Initiative has their [Municipal Canopy Summary](http://chicagorti.org/CanopySummaries) which covers each municipality in the 7-county area, plus parts of Chicago. It includes estimates for percent of land covered by trees, broken down by general land uses, as well as estimates of plantable space. Thanks to Lindsay Darling with the Morton Arboretum, this is the data set I selected for this workshop, which can be found [here](https://github.com/NicMoe/tableau-intro-with-trees/blob/master/potentialCanopy.csv)
- The USDA Forest Service has data on tree Censuses conducted within the [City of Chicago in 2007](https://www.nrs.fs.fed.us/data/urban/state/city/?city=15) and the [7-county region in 2010](https://www.nrs.fs.fed.us/data/urban/state/city/?city=26). These data sets contain count estimates by tree species, estimates of their estimates of their carbon impact, and economic value. There are also estimates of canopy cover to parasite susceptibility, by type of parasite and land use.
