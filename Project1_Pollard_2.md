ST558 Project 1
================
Tyler Pollard
6/15/2021

# Reading and Summarizing Data from the National Hockey League’s (NHL) API

## Introduction

This vignette is an introduction on how to read and summarize data using
the `tidyverse`. We will be using the National Hockey League’s (NHL)
API.

## Load Packages

Before reading and summarizing the data, some necessary packages must be
loaded.

``` r
library(httr)
library(jsonlite)
library(rmarkdown)
library(knitr)
library(tidyverse)
library(dplyr)
library(readr)
library(DT)
library(lubridate)
library(ggplot2)
library(stringr)
```

## NHL Record API

### Franchise

### Franchise Team Totals

### Season Records

### Goalie Records

### Skater Records

### Admin History and Retired Numbers

## NHL Stats API

## NHL Exploratory Data Analysis

### Newer Teams

This contigency table takes a look at the teams from the franchise
endpoint of the NHL Records API based on when they joined the NHL. I was
curious to see how many teams joined the NHL after I was born, so I
categorized all of the teams by older and younger than me. For reference
I was born in 1995. Below it can be seen that 6/39 teams joined the
league after I was born and are therefore younger than me.

| Team Age        | Count |
| :-------------- | ----: |
| Older than me   |    33 |
| Younger than me |     6 |

### Active Contigency Table

Below is a contigency table that show the number of teams that have made
the playoffs after the regular season parsed by the active and inactive
franchises. This shows that 5/13 inactive teams and 43/44 active teams
ever made the playoffs. By taking the sum of the Regular Season column
you can calculate the total number of 57 franchises represented in this
endpoint. Based on my knowledge of the NHL, I know that there are only
31 active teams currently in the league so this information is
misleading. To take a better look active the active teams that have made
the playoffs, see below.

|     | Regular Season | Playoffs |
| :-- | -------------: | -------: |
| No  |             13 |        5 |
| Yes |             44 |       43 |

### Record Contingency Tables

This is a simple contigency table that shows the number of active teams
that have ever made the playoffs after the regular season. There are 31
active teams as seen by the Regular Season row because all teams
participate in the regular season and of those 31 teams all of them have
made the playoffs before. This data was found by joining information
from the NHL Record API and the NHL Stats API.

| Game Type      | Number of Teams |
| :------------- | --------------: |
| Regular Season |              31 |
| Playoffs       |              31 |

### Goalie Single Season Records

Below is a summary table of the median values for goalie single season
records parsed by active and inactive players. Included is the number of
goalies for each player status to show the amount of data being pulled.
The data shows that goalies nowadays are a bit more active compared to
previous goalies based on the median most shots, but not by a lot. I
also wanted to include the median number of saves and median most goals
allowed to see if the skill of the goalies have increased or decreased.
Based on these values it appears that the skill level of the goalies
have remained about the same with a possible slight increase in
effectiveness.

| Players Status | Number of Goalies | Most Shots | Most Saves | Most Goals |
| :------------- | ----------------: | ---------: | ---------: | ---------: |
| Active         |               149 |         46 |         43 |          6 |
| Inactive       |               929 |         44 |         40 |          7 |

### Washington Capitals Penalty Minutes

Below is a summary table of the penalty minutes for the Washington
Capitals parsed by position. Included is the number of skaters at each
position to show the amount of data being pulled to calculate the
averages. Based on the averages the left wings and defensemen spend the
most time in the penalty box whereas the Centers seem to play a bit
cleaner. However, I found it interesting that the position with the max
amount of penalty minutes by far came from a
center.

| Position   | Number of Skaters | Average Penalty Minutes | Max Penalty Minutes |
| :--------- | ----------------: | ----------------------: | ------------------: |
| Left Wing  |               106 |                     120 |                1220 |
| Right Wing |               109 |                      99 |                1123 |
| Center     |               125 |                      86 |                2003 |
| Defensemen |               181 |                     121 |                1628 |

### Barplot of Goalies

Below is a barplot that shows the number of goalies with at least 10
shutouts in a season separated by team in order from most to least. The
purpose of this plot is to show the teams that have had the best goalies
throughout history. It should be noted that all teams are not
represented here meaning that not all teams have had a goalie with 10 or
more shutouts in a season. The teams with the most goalies are the
Detroit Red Wings and the Boston Bruins with 4 goalies followed by the
Toronto Maple Leafs, New York Rangers, and Montréal Canadiens with 3
goalies each.

![](Project1_Pollard_2_files/figure-gfm/Goalie%20Barplot-1.png)<!-- -->

### Histogram of Win Percentage

This histogram shows the density plot of the winning percentage for all
teams split up by regular season and playoffs. Overlayed is the density
distribution. From the plots it can be seen that the average winning
percentage for both regular season and playoffs is aroung .5 which means
that the teams on average win as many games as they lose. This makes
sense because the outcome of each game can only end with a single winner
and loser. Each plot is left skewed to show that more teams have been
unsuccessful in both games types.
![](Project1_Pollard_2_files/figure-gfm/percentage%20histogram-1.png)<!-- -->

### Histogram of Washington Capitals All Time Goal Leaders

Below is a histogram of the number of seasons played by all of the
Washington Capitals skaters. This plot is right skewed meaning that of
all of the skaters that have played for the Capitals the majority only
stay for a season or two. There is a drop off of skaters who stay with
the Capitals more than 10 seasons which makes sense because that is a
very long time with one franchise.
![](Project1_Pollard_2_files/figure-gfm/WSH%20goal%20histogram-1.png)<!-- -->

### Boxplot of Divsions

Below shows boxplots for season points by division with the individual
team points overlaid. Points for each team are calcualted as follows:

  - 2 points for each win
  - 1 point for an overtime/shootout loss
  - 0 points for each loss

The more points a team has the better they are considered to be. From
the visual below it can be seen that the MassMutaul East was the best
division on average, however, the best teams from the Discover Central
and Honda West were better than their best
teams.

![](Project1_Pollard_2_files/figure-gfm/Division%20Boxplot-1.png)<!-- -->

### Scatter plot

The following plots show the number of goals scored by skaters based on
the number of seasons they played. The plots are parsed by the position
that they played. Overlayed is a line of best fit with error bounds to
show the trend in the data. Based on the trend lines it can be seen that
the as the number of seasons played by skaters increased so did the
number of goals they scored. This makes sense because if you play in
more season you play more games and have more opprotunities to score
goals. I also think it is interesting that the slope of the trend lines
are almost identical for the left wings, right wings, and centers
meaning that those positions score about the same number of goals based
on the number of seasons they played. The slope for the defensemen is
much less than the other three which also makes sense because that
position has less opprotunies to
score.

![](Project1_Pollard_2_files/figure-gfm/Skater%20Scatter%20Plot-1.png)<!-- -->
