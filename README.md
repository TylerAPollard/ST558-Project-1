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
```

## NHL Record API

| ID | First Season | Full Name             | Last Season | Most Recent Team ID | Abbreviation | Common Name    | Location     |
| -: | -----------: | :-------------------- | ----------: | ------------------: | :----------- | :------------- | :----------- |
|  1 |     19171918 | Montréal Canadiens    |          NA |                   8 | MTL          | Canadiens      | Montréal     |
|  2 |     19171918 | Montreal Wanderers    |    19171918 |                  41 | MWN          | Wanderers      | Montreal     |
|  3 |     19171918 | St. Louis Eagles      |    19341935 |                  45 | SLE          | Eagles         | St. Louis    |
|  4 |     19191920 | Hamilton Tigers       |    19241925 |                  37 | HAM          | Tigers         | Hamilton     |
|  5 |     19171918 | Toronto Maple Leafs   |          NA |                  10 | TOR          | Maple Leafs    | Toronto      |
|  6 |     19241925 | Boston Bruins         |          NA |                   6 | BOS          | Bruins         | Boston       |
|  7 |     19241925 | Montreal Maroons      |    19371938 |                  43 | MMR          | Maroons        | Montreal     |
|  8 |     19251926 | Brooklyn Americans    |    19411942 |                  51 | BRK          | Americans      | Brooklyn     |
|  9 |     19251926 | Philadelphia Quakers  |    19301931 |                  39 | QUA          | Quakers        | Philadelphia |
| 10 |     19261927 | New York Rangers      |          NA |                   3 | NYR          | Rangers        | New York     |
| 11 |     19261927 | Chicago Blackhawks    |          NA |                  16 | CHI          | Blackhawks     | Chicago      |
| 12 |     19261927 | Detroit Red Wings     |          NA |                  17 | DET          | Red Wings      | Detroit      |
| 13 |     19671968 | Cleveland Barons      |    19771978 |                  49 | CLE          | Barons         | Cleveland    |
| 14 |     19671968 | Los Angeles Kings     |          NA |                  26 | LAK          | Kings          | Los Angeles  |
| 15 |     19671968 | Dallas Stars          |          NA |                  25 | DAL          | Stars          | Dallas       |
| 16 |     19671968 | Philadelphia Flyers   |          NA |                   4 | PHI          | Flyers         | Philadelphia |
| 17 |     19671968 | Pittsburgh Penguins   |          NA |                   5 | PIT          | Penguins       | Pittsburgh   |
| 18 |     19671968 | St. Louis Blues       |          NA |                  19 | STL          | Blues          | St. Louis    |
| 19 |     19701971 | Buffalo Sabres        |          NA |                   7 | BUF          | Sabres         | Buffalo      |
| 20 |     19701971 | Vancouver Canucks     |          NA |                  23 | VAN          | Canucks        | Vancouver    |
| 21 |     19721973 | Calgary Flames        |          NA |                  20 | CGY          | Flames         | Calgary      |
| 22 |     19721973 | New York Islanders    |          NA |                   2 | NYI          | Islanders      | New York     |
| 23 |     19741975 | New Jersey Devils     |          NA |                   1 | NJD          | Devils         | New Jersey   |
| 24 |     19741975 | Washington Capitals   |          NA |                  15 | WSH          | Capitals       | Washington   |
| 25 |     19791980 | Edmonton Oilers       |          NA |                  22 | EDM          | Oilers         | Edmonton     |
| 26 |     19791980 | Carolina Hurricanes   |          NA |                  12 | CAR          | Hurricanes     | Carolina     |
| 27 |     19791980 | Colorado Avalanche    |          NA |                  21 | COL          | Avalanche      | Colorado     |
| 28 |     19791980 | Arizona Coyotes       |          NA |                  53 | ARI          | Coyotes        | Arizona      |
| 29 |     19911992 | San Jose Sharks       |          NA |                  28 | SJS          | Sharks         | San Jose     |
| 30 |     19921993 | Ottawa Senators       |          NA |                   9 | OTT          | Senators       | Ottawa       |
| 31 |     19921993 | Tampa Bay Lightning   |          NA |                  14 | TBL          | Lightning      | Tampa Bay    |
| 32 |     19931994 | Anaheim Ducks         |          NA |                  24 | ANA          | Ducks          | Anaheim      |
| 33 |     19931994 | Florida Panthers      |          NA |                  13 | FLA          | Panthers       | Florida      |
| 34 |     19981999 | Nashville Predators   |          NA |                  18 | NSH          | Predators      | Nashville    |
| 35 |     19992000 | Winnipeg Jets         |          NA |                  52 | WPG          | Jets           | Winnipeg     |
| 36 |     20002001 | Columbus Blue Jackets |          NA |                  29 | CBJ          | Blue Jackets   | Columbus     |
| 37 |     20002001 | Minnesota Wild        |          NA |                  30 | MIN          | Wild           | Minnesota    |
| 38 |     20172018 | Vegas Golden Knights  |          NA |                  54 | VGK          | Golden Knights | Vegas        |
| 39 |     20212022 | Seattle Kraken        |          NA |                  55 | SEA          | Kraken         | Seattle      |
