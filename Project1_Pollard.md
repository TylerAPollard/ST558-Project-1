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
library(shiny)
library(shinyWidgets)
```

## NHL Record API

### Franchise

| Most Recent Team ID | Full Name             | Location     | Common Name    | Abbreviation | First Season | Last Season |
| ------------------: | :-------------------- | :----------- | :------------- | :----------- | -----------: | ----------: |
|                   1 | New Jersey Devils     | New Jersey   | Devils         | NJD          |     19741975 |          NA |
|                   2 | New York Islanders    | New York     | Islanders      | NYI          |     19721973 |          NA |
|                   3 | New York Rangers      | New York     | Rangers        | NYR          |     19261927 |          NA |
|                   4 | Philadelphia Flyers   | Philadelphia | Flyers         | PHI          |     19671968 |          NA |
|                   5 | Pittsburgh Penguins   | Pittsburgh   | Penguins       | PIT          |     19671968 |          NA |
|                   6 | Boston Bruins         | Boston       | Bruins         | BOS          |     19241925 |          NA |
|                   7 | Buffalo Sabres        | Buffalo      | Sabres         | BUF          |     19701971 |          NA |
|                   8 | Montréal Canadiens    | Montréal     | Canadiens      | MTL          |     19171918 |          NA |
|                   9 | Ottawa Senators       | Ottawa       | Senators       | OTT          |     19921993 |          NA |
|                  10 | Toronto Maple Leafs   | Toronto      | Maple Leafs    | TOR          |     19171918 |          NA |
|                  12 | Carolina Hurricanes   | Carolina     | Hurricanes     | CAR          |     19791980 |          NA |
|                  13 | Florida Panthers      | Florida      | Panthers       | FLA          |     19931994 |          NA |
|                  14 | Tampa Bay Lightning   | Tampa Bay    | Lightning      | TBL          |     19921993 |          NA |
|                  15 | Washington Capitals   | Washington   | Capitals       | WSH          |     19741975 |          NA |
|                  16 | Chicago Blackhawks    | Chicago      | Blackhawks     | CHI          |     19261927 |          NA |
|                  17 | Detroit Red Wings     | Detroit      | Red Wings      | DET          |     19261927 |          NA |
|                  18 | Nashville Predators   | Nashville    | Predators      | NSH          |     19981999 |          NA |
|                  19 | St. Louis Blues       | St. Louis    | Blues          | STL          |     19671968 |          NA |
|                  20 | Calgary Flames        | Calgary      | Flames         | CGY          |     19721973 |          NA |
|                  21 | Colorado Avalanche    | Colorado     | Avalanche      | COL          |     19791980 |          NA |
|                  22 | Edmonton Oilers       | Edmonton     | Oilers         | EDM          |     19791980 |          NA |
|                  23 | Vancouver Canucks     | Vancouver    | Canucks        | VAN          |     19701971 |          NA |
|                  24 | Anaheim Ducks         | Anaheim      | Ducks          | ANA          |     19931994 |          NA |
|                  25 | Dallas Stars          | Dallas       | Stars          | DAL          |     19671968 |          NA |
|                  26 | Los Angeles Kings     | Los Angeles  | Kings          | LAK          |     19671968 |          NA |
|                  28 | San Jose Sharks       | San Jose     | Sharks         | SJS          |     19911992 |          NA |
|                  29 | Columbus Blue Jackets | Columbus     | Blue Jackets   | CBJ          |     20002001 |          NA |
|                  30 | Minnesota Wild        | Minnesota    | Wild           | MIN          |     20002001 |          NA |
|                  37 | Hamilton Tigers       | Hamilton     | Tigers         | HAM          |     19191920 |    19241925 |
|                  39 | Philadelphia Quakers  | Philadelphia | Quakers        | QUA          |     19251926 |    19301931 |
|                  41 | Montreal Wanderers    | Montreal     | Wanderers      | MWN          |     19171918 |    19171918 |
|                  43 | Montreal Maroons      | Montreal     | Maroons        | MMR          |     19241925 |    19371938 |
|                  45 | St. Louis Eagles      | St. Louis    | Eagles         | SLE          |     19171918 |    19341935 |
|                  49 | Cleveland Barons      | Cleveland    | Barons         | CLE          |     19671968 |    19771978 |
|                  51 | Brooklyn Americans    | Brooklyn     | Americans      | BRK          |     19251926 |    19411942 |
|                  52 | Winnipeg Jets         | Winnipeg     | Jets           | WPG          |     19992000 |          NA |
|                  53 | Arizona Coyotes       | Arizona      | Coyotes        | ARI          |     19791980 |          NA |
|                  54 | Vegas Golden Knights  | Vegas        | Golden Knights | VGK          |     20172018 |          NA |
|                  55 | Seattle Kraken        | Seattle      | Kraken         | SEA          |     20212022 |          NA |

### Franchise Team Totals

| Franchise ID | Team Name               | Abbreviation | Team ID | Active Franchise | First Season | Last Season | Game Type      | Games Played | Goals Against | Goals For | Home Losses | Home Overtime Losses | Home Ties | Home Wins | Losses | Overtime Losses | Penalty Minutes | Point Percentage | Data Points | Road Losses | Road Overtime Losses | Road Ties | Road Wins | Shootout Losses | Shootout Wins | Shutouts | Ties | Wins |
| -----------: | :---------------------- | :----------- | ------: | :--------------- | -----------: | ----------: | :------------- | -----------: | ------------: | --------: | ----------: | -------------------: | --------: | --------: | -----: | --------------: | --------------: | ---------------: | ----------: | ----------: | -------------------: | --------: | --------: | --------------: | ------------: | -------: | ---: | ---: |
|            1 | Montréal Canadiens      | MTL          |       8 | Yes              |     19171918 |          NA | Playoffs       |          772 |          1957 |      2303 |         133 |                    0 |         3 |       257 |    321 |               0 |           12142 |           0.0000 |           0 |         188 |                    0 |         5 |       186 |               0 |             0 |       68 |    8 |  443 |
|            1 | Montréal Canadiens      | MTL          |       8 | Yes              |     19171918 |          NA | Regular Season |         6787 |         18260 |     21791 |         881 |                   95 |       381 |      2038 |   2302 |             175 |           87484 |           0.5863 |        7958 |        1421 |                   80 |       456 |      1435 |              66 |            69 |      543 |  837 | 3473 |
|            2 | Montreal Wanderers      | MWN          |      41 | No               |     19171918 |    19171918 | Regular Season |            6 |            37 |        17 |           2 |                   NA |         0 |         1 |      5 |              NA |              27 |           0.1667 |           2 |           3 |                   NA |         0 |         0 |               0 |             0 |        0 |    0 |    1 |
|            3 | Ottawa Senators (1917)  | SEN          |      36 | No               |     19171918 |    19331934 | Playoffs       |           41 |            84 |        91 |           7 |                   NA |         4 |         6 |     17 |              NA |             497 |           0.0000 |           0 |          10 |                   NA |         2 |        12 |               0 |             0 |        9 |    6 |   18 |
|            3 | Ottawa Senators (1917)  | SEN          |      36 | No               |     19171918 |    19331934 | Regular Season |          542 |          1333 |      1458 |          81 |                   NA |        30 |       160 |    221 |              NA |            5667 |           0.5341 |         579 |         140 |                   NA |        33 |        98 |               0 |             0 |       91 |   63 |  258 |
|            3 | St. Louis Eagles        | SLE          |      45 | No               |     19341935 |    19341935 | Regular Season |           48 |           144 |        86 |          14 |                   NA |         3 |         7 |     31 |              NA |             408 |           0.2917 |          28 |          17 |                   NA |         3 |         4 |               0 |             0 |        3 |    6 |   11 |
|            4 | Hamilton Tigers         | HAM          |      37 | No               |     19201921 |    19241925 | Regular Season |          126 |           475 |       414 |          30 |                   NA |         0 |        33 |     78 |              NA |            1042 |           0.3770 |          95 |          48 |                   NA |         1 |        14 |               0 |             0 |        8 |    1 |   47 |
|            4 | Quebec Bulldogs         | QBD          |      42 | No               |     19191920 |    19191920 | Regular Season |           24 |           177 |        91 |           8 |                   NA |         0 |         4 |     20 |              NA |             119 |           0.1667 |           8 |          12 |                   NA |         0 |         0 |               0 |             0 |        0 |    0 |    4 |
|            5 | Toronto Maple Leafs     | TOR          |      10 | Yes              |     19271928 |          NA | Regular Season |         6516 |         19953 |     19980 |        1082 |                   85 |       388 |      1702 |   2696 |             174 |           92331 |           0.5136 |        6693 |        1614 |                   89 |       385 |      1171 |              77 |            59 |      422 |  773 | 2873 |
|            5 | Toronto Maple Leafs     | TOR          |      10 | Yes              |     19271928 |          NA | Playoffs       |          545 |          1491 |      1398 |         120 |                    0 |         2 |       149 |    283 |               0 |            8550 |           0.0110 |          12 |         163 |                    1 |         1 |       110 |               0 |             0 |       50 |    3 |  259 |
|            5 | Toronto Arenas          | TAN          |      57 | Yes              |     19171918 |    19181919 | Regular Season |           40 |           201 |       173 |           5 |                   NA |         0 |        15 |     22 |              NA |             696 |           0.4500 |          36 |          17 |                   NA |         0 |         3 |               0 |             0 |        0 |    0 |   18 |
|            5 | Toronto Arenas          | TAN          |      57 | Yes              |     19171918 |    19181919 | Playoffs       |            7 |            28 |        28 |           2 |                   NA |         0 |         4 |      3 |              NA |             176 |           0.0000 |           0 |           1 |                   NA |         0 |         0 |               0 |             0 |        0 |    0 |    4 |
|            5 | Toronto St. Patricks    | TSP          |      58 | Yes              |     19191920 |    19261927 | Playoffs       |           11 |            25 |        23 |           4 |                   NA |         0 |         4 |      6 |              NA |             123 |           0.0000 |           0 |           2 |                   NA |         1 |         0 |               0 |             0 |        2 |    1 |    4 |
|            5 | Toronto St. Patricks    | TSP          |      58 | Yes              |     19191920 |    19261927 | Regular Season |          230 |           768 |       724 |          37 |                   NA |         5 |        73 |    111 |              NA |            2339 |           0.4957 |         228 |          74 |                   NA |         5 |        36 |               0 |             0 |        9 |   10 |  109 |
|            6 | Boston Bruins           | BOS          |       6 | Yes              |     19241925 |          NA | Regular Season |         6626 |         19137 |     21112 |         960 |                   92 |       376 |      1885 |   2403 |             191 |           88570 |           0.5632 |        7464 |        1443 |                   99 |       415 |      1356 |              82 |            68 |      506 |  791 | 3241 |
|            6 | Boston Bruins           | BOS          |       6 | Yes              |     19241925 |          NA | Playoffs       |          675 |          1907 |      1956 |         151 |                    2 |         3 |       194 |    337 |               0 |           10607 |           0.0296 |          40 |         186 |                    2 |         3 |       138 |               0 |             0 |       49 |    6 |  332 |
|            7 | Montreal Maroons        | MMR          |      43 | No               |     19241925 |    19371938 | Regular Season |          622 |          1405 |      1474 |         107 |                   NA |        48 |       156 |    260 |              NA |            7330 |           0.5088 |         633 |         153 |                   NA |        43 |       115 |               0 |             0 |       75 |   91 |  271 |
|            7 | Montreal Maroons        | MMR          |      43 | No               |     19241925 |    19371938 | Playoffs       |           50 |            79 |        74 |          12 |                   NA |         8 |         9 |     21 |              NA |             535 |           0.0000 |           0 |           9 |                   NA |         1 |        11 |               0 |             0 |       13 |    9 |   20 |
|            8 | New York Americans      | NYA          |      44 | No               |     19251926 |    19401941 | Regular Season |          736 |          2007 |      1510 |         154 |                   NA |        67 |       147 |    373 |              NA |            6348 |           0.4090 |         602 |         219 |                   NA |        57 |        92 |               0 |             0 |       84 |  124 |  239 |
|            8 | New York Americans      | NYA          |      44 | No               |     19251926 |    19401941 | Playoffs       |           18 |            42 |        32 |           3 |                   NA |         1 |         4 |     11 |              NA |             155 |           0.0000 |           0 |           8 |                   NA |         0 |         2 |               0 |             0 |        3 |    1 |    6 |
|            8 | Brooklyn Americans      | BRK          |      51 | No               |     19411942 |    19411942 | Regular Season |           48 |           175 |       133 |          12 |                   NA |         2 |        10 |     29 |              NA |             425 |           0.3646 |          35 |          17 |                   NA |         1 |         6 |               0 |             0 |        1 |    3 |   16 |
|            9 | Pittsburgh Pirates      | PIR          |      38 | No               |     19251926 |    19291930 | Regular Season |          212 |           519 |       376 |          55 |                   NA |        10 |        41 |    122 |              NA |            1620 |           0.3703 |         157 |          67 |                   NA |        13 |        26 |               0 |             0 |       33 |   23 |   67 |
|            9 | Pittsburgh Pirates      | PIR          |      38 | No               |     19251926 |    19291930 | Playoffs       |            4 |            12 |         8 |           1 |                   NA |         0 |         0 |      2 |              NA |              20 |           0.0000 |           0 |           1 |                   NA |         1 |         1 |               0 |             0 |        0 |    1 |    1 |
|            9 | Philadelphia Quakers    | QUA          |      39 | No               |     19301931 |    19301931 | Regular Season |           44 |           184 |        76 |          17 |                   NA |         2 |         3 |     36 |              NA |             503 |           0.1364 |          12 |          19 |                   NA |         2 |         1 |               0 |             0 |        1 |    4 |    4 |
|           10 | New York Rangers        | NYR          |       3 | Yes              |     19261927 |          NA | Regular Season |         6560 |         20020 |     20041 |        1143 |                   76 |       448 |      1614 |   2716 |             153 |           86129 |           0.5127 |        6727 |        1573 |                   77 |       360 |      1269 |              68 |            79 |      408 |  808 | 2883 |
|           10 | New York Rangers        | NYR          |       3 | Yes              |     19261927 |          NA | Playoffs       |          518 |          1447 |      1404 |         104 |                    0 |         1 |       137 |    266 |               0 |            8181 |           0.0000 |           0 |         162 |                    0 |         7 |       107 |               0 |             0 |       44 |    8 |  244 |
|           11 | Chicago Blackhawks      | CHI          |      16 | Yes              |     19261927 |          NA | Playoffs       |          548 |          1669 |      1566 |         104 |                    0 |         1 |       166 |    275 |               0 |            8855 |           0.0000 |           0 |         171 |                    1 |         4 |       102 |               0 |             0 |       32 |    5 |  268 |
|           11 | Chicago Blackhawks      | CHI          |      16 | Yes              |     19261927 |          NA | Regular Season |         6560 |         19687 |     19537 |        1128 |                   86 |       410 |      1655 |   2761 |             173 |           92285 |           0.5039 |        6611 |        1633 |                   87 |       404 |      1157 |              70 |            75 |      439 |  814 | 2812 |
|           12 | Detroit Red Wings       | DET          |      17 | Yes              |     19321933 |          NA | Regular Season |         6293 |         18881 |     19550 |         940 |                   99 |       368 |      1741 |   2446 |             183 |           84403 |           0.5354 |        6738 |        1506 |                   84 |       405 |      1150 |              76 |            71 |      423 |  773 | 2891 |
|           12 | Detroit Red Wings       | DET          |      17 | Yes              |     19321933 |          NA | Playoffs       |          618 |          1565 |      1745 |         126 |                    0 |         0 |       188 |    293 |               0 |            8735 |           0.0000 |           0 |         167 |                    0 |         0 |       137 |               0 |             0 |       66 |    0 |  325 |
|           12 | Detroit Cougars         | DCG          |      40 | Yes              |     19261927 |    19291930 | Regular Season |          176 |           380 |       353 |          42 |                   NA |        11 |        35 |     87 |              NA |            1718 |           0.4347 |         153 |          45 |                   NA |        14 |        29 |               0 |             0 |       29 |   25 |   64 |
|           12 | Detroit Cougars         | DCG          |      40 | Yes              |     19261927 |    19291930 | Playoffs       |            2 |             7 |         2 |           1 |                   NA |         0 |         0 |      2 |              NA |              24 |           0.0000 |           0 |           1 |                   NA |         0 |         0 |               0 |             0 |        0 |    0 |    0 |
|           12 | Detroit Falcons         | DFL          |      50 | Yes              |     19301931 |    19311932 | Regular Season |           92 |           213 |       197 |          10 |                   NA |        11 |        25 |     41 |              NA |             858 |           0.4620 |          85 |          31 |                   NA |         6 |         9 |               0 |             0 |       12 |   17 |   34 |
|           12 | Detroit Falcons         | DFL          |      50 | Yes              |     19301931 |    19311932 | Playoffs       |            2 |             3 |         1 |           0 |                   NA |         1 |         0 |      1 |              NA |              12 |           0.0000 |           0 |           1 |                   NA |         0 |         0 |               0 |             0 |        0 |    1 |    0 |
|           13 | Oakland Seals           | OAK          |      46 | No               |     19671968 |    19691970 | Regular Season |          226 |           713 |       541 |          46 |                   NA |        23 |        44 |    118 |              NA |            2443 |           0.3850 |         174 |          72 |                   NA |        19 |        22 |               0 |             0 |       11 |   42 |   66 |
|           13 | Oakland Seals           | OAK          |      46 | No               |     19671968 |    19691970 | Playoffs       |           11 |            36 |        31 |           4 |                   NA |        NA |         2 |      8 |              NA |             152 |           0.0000 |           0 |           4 |                   NA |        NA |         1 |               0 |             0 |        0 |   NA |    3 |
|           13 | Cleveland Barons        | CLE          |      49 | No               |     19761977 |    19771978 | Regular Season |          160 |           617 |       470 |          34 |                   NA |        18 |        28 |     87 |              NA |            2021 |           0.3750 |         120 |          53 |                   NA |         8 |        19 |               0 |             0 |        6 |   26 |   47 |
|           13 | California Golden Seals | CGS          |      56 | No               |     19701971 |    19751976 | Regular Season |          472 |          1867 |      1285 |         100 |                   NA |        52 |        84 |    283 |              NA |            5594 |           0.3231 |         305 |         183 |                   NA |        21 |        32 |               0 |             0 |       15 |   73 |  116 |
|           14 | Los Angeles Kings       | LAK          |      26 | Yes              |     19671968 |          NA | Regular Season |         4172 |         13761 |     13053 |         776 |                   71 |       211 |      1027 |   1829 |             165 |           65875 |           0.4910 |        4097 |        1053 |                   94 |       213 |       727 |              71 |            69 |      234 |  424 | 1754 |
|           14 | Los Angeles Kings       | LAK          |      26 | Yes              |     19671968 |          NA | Playoffs       |          255 |           851 |       745 |          60 |                    0 |        NA |        62 |    144 |               0 |            4399 |           0.0000 |           0 |          84 |                    0 |        NA |        49 |               0 |             0 |       14 |   NA |  111 |
|           15 | Dallas Stars            | DAL          |      25 | Yes              |     19931994 |          NA | Regular Season |         2109 |          5609 |      6022 |         314 |                   81 |        65 |       594 |    738 |             162 |           28050 |           0.5820 |        2455 |         424 |                   81 |        60 |       490 |              62 |            73 |      150 |  125 | 1084 |
|           15 | Dallas Stars            | DAL          |      25 | Yes              |     19931994 |          NA | Playoffs       |          200 |           504 |       511 |          46 |                    0 |        NA |        54 |     95 |               0 |            2619 |           0.0350 |          14 |          49 |                    2 |        NA |        51 |               0 |             1 |       15 |   NA |  105 |
|           15 | Minnesota North Stars   | MNS          |      31 | Yes              |     19671968 |    19921993 | Regular Season |         2062 |          7373 |      6690 |         391 |                   NA |       163 |       477 |    970 |              NA |           36310 |           0.4486 |        1850 |         579 |                   NA |       171 |       281 |               0 |             0 |       70 |  334 |  758 |
|           15 | Minnesota North Stars   | MNS          |      31 | Yes              |     19671968 |    19921993 | Playoffs       |          166 |           580 |       552 |          33 |                   NA |        NA |        45 |     86 |              NA |            3468 |           0.0000 |           0 |          53 |                   NA |        NA |        35 |               0 |             0 |        9 |   NA |   80 |
|           16 | Philadelphia Flyers     | PHI          |       4 | Yes              |     19671968 |          NA | Playoffs       |          449 |          1332 |      1335 |          97 |                    0 |        NA |       135 |    218 |               0 |            9104 |           0.0045 |           4 |         121 |                    0 |        NA |        96 |               0 |             0 |       33 |   NA |  231 |
|           16 | Philadelphia Flyers     | PHI          |       4 | Yes              |     19671968 |          NA | Regular Season |         4171 |         12255 |     13690 |         584 |                   93 |       193 |      1216 |   1452 |             183 |           76208 |           0.5752 |        4798 |         868 |                   90 |       264 |       863 |              92 |            53 |      248 |  457 | 2079 |
|           17 | Pittsburgh Penguins     | PIT          |       5 | Yes              |     19671968 |          NA | Regular Season |         4171 |         14049 |     13874 |         683 |                   60 |       205 |      1138 |   1734 |             151 |           66221 |           0.5203 |        4340 |        1051 |                   91 |       178 |       765 |              54 |            83 |      189 |  383 | 1903 |
|           17 | Pittsburgh Penguins     | PIT          |       5 | Yes              |     19671968 |          NA | Playoffs       |          391 |          1131 |      1190 |          85 |                    0 |        NA |       113 |    182 |               0 |            6106 |           0.0153 |          12 |          97 |                    1 |        NA |        96 |               0 |             0 |       30 |   NA |  209 |
|           18 | St. Louis Blues         | STL          |      19 | Yes              |     19671968 |          NA | Regular Season |         4173 |         12688 |     12827 |         674 |                   72 |       218 |      1122 |   1645 |             167 |           65608 |           0.5340 |        4457 |         971 |                   95 |       214 |       807 |              69 |            74 |      252 |  432 | 1929 |
|           18 | St. Louis Blues         | STL          |      19 | Yes              |     19671968 |          NA | Playoffs       |          404 |          1227 |      1103 |          92 |                    3 |        NA |       108 |    221 |               1 |            7730 |           0.0396 |          32 |         129 |                    0 |        NA |        74 |               1 |             0 |       21 |   NA |  182 |
|           19 | Buffalo Sabres          | BUF          |       7 | Yes              |     19701971 |          NA | Regular Season |         3945 |         11966 |     12471 |         639 |                   84 |       197 |      1053 |   1564 |             167 |           60671 |           0.5305 |        4186 |         925 |                   83 |       212 |       752 |              74 |            81 |      194 |  409 | 1805 |
|           19 | Buffalo Sabres          | BUF          |       7 | Yes              |     19701971 |          NA | Playoffs       |          256 |           765 |       763 |          54 |                    0 |        NA |        73 |    132 |               0 |            4692 |           0.0000 |           0 |          78 |                    0 |        NA |        51 |               0 |             0 |       18 |   NA |  124 |
|           20 | Vancouver Canucks       | VAN          |      23 | Yes              |     19701971 |          NA | Regular Season |         3945 |         12999 |     12138 |         736 |                   84 |       210 |       943 |   1746 |             159 |           66856 |           0.4877 |        3848 |        1010 |                   75 |       181 |       706 |              76 |            72 |      169 |  391 | 1649 |
|           20 | Vancouver Canucks       | VAN          |      23 | Yes              |     19701971 |          NA | Playoffs       |          246 |           780 |       682 |          68 |                    0 |        NA |        56 |    135 |               0 |            4755 |           0.0000 |           0 |          67 |                    0 |        NA |        55 |               0 |             0 |       14 |   NA |  111 |
|           21 | Calgary Flames          | CGY          |      20 | Yes              |     19801981 |          NA | Playoffs       |          221 |           730 |       696 |          52 |                    1 |        NA |        60 |    118 |               0 |            5118 |           0.0045 |           2 |          66 |                    1 |        NA |        43 |               0 |             0 |       14 |   NA |  103 |
|           21 | Calgary Flames          | CGY          |      20 | Yes              |     19801981 |          NA | Regular Season |         3154 |          9821 |     10257 |         508 |                   69 |       135 |       863 |   1236 |             150 |           55423 |           0.5414 |        3415 |         728 |                   81 |       136 |       634 |              65 |            52 |      144 |  271 | 1497 |
|           21 | Atlanta Flames          | AFM          |      47 | Yes              |     19721973 |    19791980 | Regular Season |          636 |          2013 |      2057 |         104 |                   NA |        53 |       161 |    260 |              NA |            7608 |           0.5063 |         644 |         156 |                   NA |        55 |       107 |               0 |             0 |       34 |  108 |  268 |
|           21 | Atlanta Flames          | AFM          |      47 | Yes              |     19721973 |    19791980 | Playoffs       |           17 |            62 |        32 |           6 |                   NA |        NA |         2 |     15 |              NA |             461 |           0.0000 |           0 |           9 |                   NA |        NA |         0 |               0 |             0 |        0 |   NA |    2 |
|           22 | New York Islanders      | NYI          |       2 | Yes              |     19721973 |          NA | Regular Season |         3788 |         11907 |     12045 |         678 |                   84 |       170 |       963 |   1587 |             166 |           57792 |           0.5133 |        3889 |         909 |                   82 |       177 |       725 |              70 |            86 |      177 |  347 | 1688 |
|           22 | New York Islanders      | NYI          |       2 | Yes              |     19721973 |          NA | Playoffs       |          309 |           897 |       983 |          53 |                    1 |        NA |        94 |    139 |               0 |            5689 |           0.0129 |           8 |          86 |                    2 |        NA |        76 |               0 |             0 |       12 |   NA |  170 |
|           23 | New Jersey Devils       | NJD          |       1 | Yes              |     19821983 |          NA | Regular Season |         2993 |          8902 |      8792 |         525 |                   85 |        96 |       790 |   1211 |             169 |           44773 |           0.5306 |        3176 |         686 |                   84 |       123 |       604 |              84 |            78 |      196 |  219 | 1394 |
|           23 | New Jersey Devils       | NJD          |       1 | Yes              |     19821983 |          NA | Playoffs       |          257 |           634 |       697 |          53 |                    0 |        NA |        74 |    120 |               0 |            4266 |           0.0039 |           2 |          67 |                    0 |        NA |        63 |               0 |             0 |       25 |   NA |  137 |
|           23 | Colorado Rockies        | CLR          |      35 | Yes              |     19761977 |    19811982 | Regular Season |          480 |          1957 |      1426 |         115 |                   NA |        47 |        78 |    281 |              NA |            6216 |           0.3250 |         312 |         166 |                   NA |        39 |        35 |               0 |             0 |        3 |   86 |  113 |
|           23 | Colorado Rockies        | CLR          |      35 | Yes              |     19761977 |    19811982 | Playoffs       |            2 |             6 |         3 |           1 |                   NA |        NA |         0 |      2 |              NA |              25 |           0.0000 |           0 |           1 |                   NA |        NA |         0 |               0 |             0 |        0 |   NA |    0 |
|           23 | Kansas City Scouts      | KCS          |      48 | Yes              |     19741975 |    19751976 | Regular Season |          160 |           679 |       374 |          44 |                   NA |        16 |        20 |    110 |              NA |            1726 |           0.2406 |          77 |          66 |                   NA |         7 |         7 |               0 |             0 |        0 |   23 |   27 |
|           24 | Washington Capitals     | WSH          |      15 | Yes              |     19741975 |          NA | Regular Season |         3633 |         11553 |     11516 |         620 |                   83 |       153 |       959 |   1467 |             163 |           57455 |           0.5321 |        3866 |         847 |                   80 |       150 |       741 |              71 |            68 |      178 |  303 | 1700 |
|           24 | Washington Capitals     | WSH          |      15 | Yes              |     19741975 |          NA | Playoffs       |          295 |           837 |       836 |          77 |                    1 |        NA |        75 |    156 |               1 |            5152 |           0.0644 |          38 |          79 |                    2 |        NA |        63 |               1 |             0 |       19 |   NA |  138 |
|           25 | Edmonton Oilers         | EDM          |      22 | Yes              |     19791980 |          NA | Regular Season |         3235 |         10633 |     10776 |         587 |                   74 |       125 |       830 |   1337 |             167 |           55008 |           0.5204 |        3367 |         750 |                   93 |       137 |       639 |              69 |            75 |      122 |  262 | 1469 |
|           25 | Edmonton Oilers         | EDM          |      22 | Yes              |     19791980 |          NA | Playoffs       |          272 |           825 |       994 |          48 |                    0 |        NA |        91 |    112 |               0 |            5756 |           0.0000 |           0 |          64 |                    0 |        NA |        69 |               0 |             0 |       14 |   NA |  160 |
|           26 | Carolina Hurricanes     | CAR          |      12 | Yes              |     19971998 |          NA | Playoffs       |          112 |           282 |       272 |          24 |                    0 |        NA |        32 |     54 |               0 |            1310 |           0.0714 |          16 |          30 |                    2 |        NA |        26 |               0 |             0 |       11 |   NA |   58 |
|           26 | Carolina Hurricanes     | CAR          |      12 | Yes              |     19971998 |          NA | Regular Season |         1812 |          5140 |      4914 |         323 |                   77 |        52 |       453 |    725 |             174 |           19429 |           0.5281 |        1914 |         402 |                   97 |        34 |       374 |              61 |            50 |       99 |   86 |  827 |
|           26 | Hartford Whalers        | HFD          |      34 | Yes              |     19791980 |    19961997 | Regular Season |         1420 |          5345 |      4704 |         297 |                   NA |        95 |       318 |    709 |              NA |           29656 |           0.4384 |        1245 |         412 |                   NA |        82 |       216 |               0 |             0 |       50 |  177 |  534 |
|           26 | Hartford Whalers        | HFD          |      34 | Yes              |     19791980 |    19961997 | Playoffs       |           49 |           177 |       143 |          10 |                   NA |        NA |        12 |     31 |              NA |            1273 |           0.0000 |           0 |          21 |                   NA |        NA |         6 |               0 |             0 |        1 |   NA |   18 |
|           27 | Colorado Avalanche      | COL          |      21 | Yes              |     19951996 |          NA | Regular Season |         1978 |          5458 |      5857 |         327 |                   62 |        55 |       543 |    728 |             142 |           25410 |           0.5705 |        2257 |         401 |                   80 |        46 |       464 |              42 |            73 |      124 |  101 | 1007 |
|           27 | Colorado Avalanche      | COL          |      21 | Yes              |     19951996 |          NA | Playoffs       |          219 |           560 |       647 |          44 |                    1 |        NA |        69 |     94 |               1 |            2970 |           0.0411 |          18 |          50 |                    0 |        NA |        55 |               0 |             0 |       23 |   NA |  124 |
|           27 | Quebec Nordiques        | QUE          |      32 | Yes              |     19791980 |    19941995 | Playoffs       |           80 |           286 |       247 |          17 |                   NA |        NA |        21 |     45 |              NA |            2434 |           0.0000 |           0 |          28 |                   NA |        NA |        14 |               0 |             0 |        1 |   NA |   35 |
|           27 | Quebec Nordiques        | QUE          |      32 | Yes              |     19791980 |    19941995 | Regular Season |         1256 |          4883 |      4625 |         245 |                   NA |        83 |       300 |    599 |              NA |           27013 |           0.4594 |        1154 |         354 |                   NA |        77 |       197 |               0 |             0 |       28 |  160 |  497 |
|           28 | Phoenix Coyotes         | PHX          |      27 | Yes              |     19961997 |    20132014 | Regular Season |         1360 |          3824 |      3632 |         249 |                   48 |        43 |       340 |    546 |             105 |           19860 |           0.5254 |        1429 |         297 |                   57 |        51 |       275 |              49 |            52 |      105 |   94 |  615 |
|           28 | Phoenix Coyotes         | PHX          |      27 | Yes              |     19961997 |    20132014 | Playoffs       |           57 |           169 |       133 |          19 |                    0 |        NA |        10 |     35 |               0 |             837 |           0.0000 |           0 |          16 |                    0 |        NA |        12 |               0 |             0 |        4 |   NA |   22 |
|           28 | Winnipeg Jets (1979)    | WIN          |      33 | Yes              |     19791980 |    19951996 | Regular Season |         1338 |          5347 |      4762 |         274 |                   NA |        88 |       307 |    660 |              NA |           27371 |           0.4425 |        1184 |         386 |                   NA |        84 |       199 |               0 |             0 |       37 |  172 |  506 |
|           28 | Winnipeg Jets (1979)    | WIN          |      33 | Yes              |     19791980 |    19951996 | Playoffs       |           62 |           253 |       177 |          16 |                   NA |        NA |        12 |     43 |              NA |            1546 |           0.0000 |           0 |          27 |                   NA |        NA |         7 |               0 |             0 |        0 |   NA |   19 |
|           28 | Arizona Coyotes         | ARI          |      53 | Yes              |     20142015 |          NA | Regular Season |          536 |          1619 |      1345 |         120 |                   30 |        NA |       116 |    262 |              60 |            4715 |           0.4552 |         488 |         142 |                   30 |        NA |        98 |              22 |            26 |       28 |   NA |  214 |
|           28 | Arizona Coyotes         | ARI          |      53 | Yes              |     20142015 |          NA | Playoffs       |            9 |            33 |        22 |           1 |                    0 |        NA |         3 |      5 |               0 |              80 |               NA |          NA |           4 |                    0 |        NA |         1 |               0 |             0 |        0 |   NA |    4 |
|           29 | San Jose Sharks         | SJS          |      28 | Yes              |     19911992 |          NA | Playoffs       |          241 |           691 |       631 |          52 |                    0 |        NA |        67 |    122 |               0 |            3034 |           0.0664 |          32 |          70 |                    1 |        NA |        52 |               0 |             0 |       15 |   NA |  119 |
|           29 | San Jose Sharks         | SJS          |      28 | Yes              |     19911992 |          NA | Regular Season |         2274 |          6618 |      6490 |         407 |                   84 |        58 |       589 |    920 |             163 |           31739 |           0.5330 |        2424 |         513 |                   79 |        63 |       481 |              67 |            76 |      157 |  121 | 1070 |
|           30 | Ottawa Senators         | OTT          |       9 | Yes              |     19921993 |          NA | Regular Season |         2195 |          6580 |      6250 |         413 |                   93 |        60 |       533 |    940 |             169 |           29684 |           0.5071 |        2226 |         527 |                   76 |        55 |       438 |              79 |            58 |      137 |  115 |  971 |
|           30 | Ottawa Senators         | OTT          |       9 | Yes              |     19921993 |          NA | Playoffs       |          151 |           372 |       357 |          35 |                    0 |        NA |        37 |     79 |               0 |            2102 |           0.0000 |           0 |          44 |                    0 |        NA |        35 |               0 |             0 |       12 |   NA |   72 |
|           31 | Tampa Bay Lightning     | TBL          |      14 | Yes              |     19921993 |          NA | Regular Season |         2194 |          6646 |      6216 |         414 |                   67 |        56 |       559 |    947 |             150 |           31086 |           0.5087 |        2232 |         533 |                   83 |        56 |       426 |              59 |            68 |      124 |  112 |  985 |
|           31 | Tampa Bay Lightning     | TBL          |      14 | Yes              |     19921993 |          NA | Playoffs       |          176 |           458 |       485 |          43 |                    0 |        NA |        48 |     75 |               0 |            2444 |           0.0625 |          22 |          32 |                    0 |        NA |        53 |               0 |             1 |       14 |   NA |  101 |
|           32 | Anaheim Ducks           | ANA          |      24 | Yes              |     19931994 |          NA | Playoffs       |          162 |           421 |       433 |          34 |                    0 |        NA |        51 |     73 |               0 |            2302 |           0.0000 |           0 |          39 |                    0 |        NA |        38 |               0 |             0 |       16 |   NA |   89 |
|           32 | Anaheim Ducks           | ANA          |      24 | Yes              |     19931994 |          NA | Regular Season |         2111 |          5838 |      5693 |         359 |                   82 |        58 |       557 |    834 |             180 |           30579 |           0.5369 |        2267 |         475 |                   98 |        49 |       433 |              78 |            71 |      137 |  107 |  990 |
|           33 | Florida Panthers        | FLA          |      13 | Yes              |     19931994 |          NA | Regular Season |         2109 |          6122 |      5665 |         390 |                  115 |        65 |       485 |    870 |             208 |           29171 |           0.5045 |        2128 |         480 |                   93 |        77 |       404 |              97 |            71 |      115 |  142 |  889 |
|           33 | Florida Panthers        | FLA          |      13 | Yes              |     19931994 |          NA | Playoffs       |           54 |           152 |       132 |          15 |                    0 |        NA |        13 |     33 |               0 |             775 |           0.0000 |           0 |          18 |                    0 |        NA |         8 |               0 |             0 |        3 |   NA |   21 |
|           34 | Nashville Predators     | NSH          |      18 | Yes              |     19981999 |          NA | Regular Season |         1731 |          4708 |      4730 |         282 |                   73 |        34 |       477 |    656 |             163 |           19933 |           0.5566 |        1927 |         374 |                   90 |        26 |       375 |              70 |            74 |      134 |   60 |  852 |
|           34 | Nashville Predators     | NSH          |      18 | Yes              |     19981999 |          NA | Playoffs       |          121 |           340 |       307 |          27 |                    0 |        NA |        34 |     67 |               0 |            1377 |           0.0744 |          18 |          40 |                    2 |        NA |        20 |               0 |             0 |        6 |   NA |   54 |
|           35 | Atlanta Thrashers       | ATL          |      11 | Yes              |     19992000 |    20102011 | Regular Season |          902 |          3014 |      2465 |         204 |                   38 |        26 |       183 |    437 |              78 |           13727 |           0.4473 |         807 |         233 |                   40 |        19 |       159 |              29 |            37 |       41 |   45 |  342 |
|           35 | Atlanta Thrashers       | ATL          |      11 | Yes              |     19992000 |    20102011 | Playoffs       |            4 |            17 |         6 |           2 |                    0 |        NA |         0 |      4 |               0 |             115 |           0.0000 |           0 |           2 |                    0 |        NA |         0 |               0 |             0 |        0 |   NA |    0 |
|           35 | Winnipeg Jets           | WPG          |      52 | Yes              |     20112012 |          NA | Playoffs       |           39 |           112 |       104 |          13 |                    0 |        NA |         7 |     23 |               0 |             330 |           0.2821 |          22 |          10 |                    0 |        NA |         9 |               0 |             0 |        3 |   NA |   16 |
|           35 | Winnipeg Jets           | WPG          |      52 | Yes              |     20112012 |          NA | Regular Season |          749 |          2151 |      2209 |         136 |                   33 |        NA |       207 |    292 |              75 |            7621 |           0.5601 |         839 |         156 |                   42 |        NA |       175 |              30 |            36 |       46 |   NA |  382 |
|           36 | Columbus Blue Jackets   | CBJ          |      29 | Yes              |     20002001 |          NA | Regular Season |         1568 |          4612 |      4092 |         300 |                   77 |        18 |       390 |    698 |             159 |           19835 |           0.4936 |        1548 |         398 |                   82 |        15 |       288 |              72 |            71 |      105 |   33 |  678 |
|           36 | Columbus Blue Jackets   | CBJ          |      29 | Yes              |     20002001 |          NA | Playoffs       |           41 |           133 |       110 |          13 |                    0 |        NA |         6 |     26 |               0 |             387 |           0.1951 |          16 |          13 |                    3 |        NA |         9 |               0 |             0 |        2 |   NA |   15 |
|           37 | Minnesota Wild          | MIN          |      30 | Yes              |     20002001 |          NA | Regular Season |         1567 |          4135 |      4166 |         243 |                   84 |        28 |       429 |    599 |             154 |           17134 |           0.5511 |        1727 |         356 |                   70 |        27 |       330 |              70 |            71 |      113 |   55 |  759 |
|           37 | Minnesota Wild          | MIN          |      30 | Yes              |     20002001 |          NA | Playoffs       |           84 |           231 |       187 |          24 |                    0 |        NA |        15 |     54 |               0 |             882 |           0.0119 |           2 |          30 |                    0 |        NA |        15 |               0 |             0 |        7 |   NA |   30 |
|           38 | Vegas Golden Knights    | VGK          |      54 | Yes              |     20172018 |          NA | Regular Season |          291 |           793 |       939 |          38 |                   13 |        NA |        96 |     94 |              24 |            2117 |           0.6357 |         370 |          56 |                   11 |        NA |        77 |               9 |            11 |       27 |   NA |  173 |
|           38 | Vegas Golden Knights    | VGK          |      54 | Yes              |     20172018 |          NA | Playoffs       |           62 |           149 |       185 |          11 |                    1 |        NA |        22 |     25 |               0 |             628 |           0.2581 |          32 |          14 |                    2 |        NA |        15 |               0 |             0 |       10 |   NA |   37 |

### Season Records

|                                |                                                                                                                                                                                                                                                                     |
| :----------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| data.franchiseName             | New Jersey Devils                                                                                                                                                                                                                                                   |
| data.franchiseId               | 23                                                                                                                                                                                                                                                                  |
| data.fewestGoals               | 174                                                                                                                                                                                                                                                                 |
| data.fewestGoalsAgainst        | 164                                                                                                                                                                                                                                                                 |
| data.fewestGoalsAgainstSeasons | 2003-04 (82)                                                                                                                                                                                                                                                        |
| data.fewestGoalsSeasons        | 2010-11 (82)                                                                                                                                                                                                                                                        |
| data.fewestLosses              | 19                                                                                                                                                                                                                                                                  |
| data.fewestLossesSeasons       | 2000-01 (82)                                                                                                                                                                                                                                                        |
| data.fewestPoints              | 36                                                                                                                                                                                                                                                                  |
| data.fewestPointsSeasons       | 1975-76 (80)                                                                                                                                                                                                                                                        |
| data.fewestTies                | 3                                                                                                                                                                                                                                                                   |
| data.fewestTiesSeasons         | 1985-86 (80)                                                                                                                                                                                                                                                        |
| data.fewestWins                | 12                                                                                                                                                                                                                                                                  |
| data.fewestWinsSeasons         | 1975-76 (80)                                                                                                                                                                                                                                                        |
| data.homeLossStreak            | 10                                                                                                                                                                                                                                                                  |
| data.homeLossStreakDates       | Jan 26 2021 - Mar 13 2021                                                                                                                                                                                                                                           |
| data.homePointStreak           | 15                                                                                                                                                                                                                                                                  |
| data.homePointStreakDates      | Jan 08 1997 - Mar 15 1997, Dec 14 1999 - Feb 17 2000                                                                                                                                                                                                                |
| data.homeWinStreak             | 11                                                                                                                                                                                                                                                                  |
| data.homeWinStreakDates        | Feb 09 2009 - Mar 20 2009                                                                                                                                                                                                                                           |
| data.homeWinlessStreak         | 14                                                                                                                                                                                                                                                                  |
| data.homeWinlessStreakDates    | Feb 12 1976 - Mar 30 1976, Feb 04 1979 - Mar 31 1979                                                                                                                                                                                                                |
| data.lossStreak                | 14                                                                                                                                                                                                                                                                  |
| data.lossStreakDates           | Dec 30 1975 - Jan 29 1976                                                                                                                                                                                                                                           |
| data.mostGameGoals             | 9                                                                                                                                                                                                                                                                   |
| data.mostGameGoalsDates        | Apr 01 1979 - STL 5 @ CLR 9, Feb 12 1982 - QUE 2 @ CLR 9, Apr 06 1986 - NYI 7 @ NJD 9, Mar 10 1990 - QUE 3 @ NJD 9, Dec 05 1990 - VAN 4 @ NJD 9, Oct 26 1991 - SJS 0 @ NJD 9, Mar 23 1993 - TBL 3 @ NJD 9, Mar 10 2000 - NJD 9 @ ATL 0, Oct 28 2000 - NJD 9 @ PIT 0 |
| data.mostGoals                 | 308                                                                                                                                                                                                                                                                 |
| data.mostGoalsAgainst          | 374                                                                                                                                                                                                                                                                 |
| data.mostGoalsAgainstSeasons   | 1985-86 (80)                                                                                                                                                                                                                                                        |
| data.mostGoalsSeasons          | 1992-93 (84)                                                                                                                                                                                                                                                        |
| data.mostLosses                | 56                                                                                                                                                                                                                                                                  |
| data.mostLossesSeasons         | 1975-76 (80), 1983-84 (80)                                                                                                                                                                                                                                          |
| data.mostPenaltyMinutes        | 2494                                                                                                                                                                                                                                                                |
| data.mostPenaltyMinutesSeasons | 1988-89 (80)                                                                                                                                                                                                                                                        |
| data.mostPoints                | 111                                                                                                                                                                                                                                                                 |
| data.mostPointsSeasons         | 2000-01 (82)                                                                                                                                                                                                                                                        |
| data.mostShutouts              | 14                                                                                                                                                                                                                                                                  |
| data.mostShutoutsSeasons       | 2003-04 (82)                                                                                                                                                                                                                                                        |
| data.mostTies                  | 21                                                                                                                                                                                                                                                                  |
| data.mostTiesSeasons           | 1977-78 (80)                                                                                                                                                                                                                                                        |
| data.mostWins                  | 51                                                                                                                                                                                                                                                                  |
| data.mostWinsSeasons           | 2008-09 (82)                                                                                                                                                                                                                                                        |
| data.pointStreak               | 16                                                                                                                                                                                                                                                                  |
| data.pointStreakDates          | Dec 26 1999 - Jan 28 2000                                                                                                                                                                                                                                           |
| data.roadLossStreak            | 12                                                                                                                                                                                                                                                                  |
| data.roadLossStreakDates       | Oct 19 1983 - Dec 01 1983                                                                                                                                                                                                                                           |
| data.roadPointStreak           | 10                                                                                                                                                                                                                                                                  |
| data.roadPointStreakDates      | Feb 27 2001 - Apr 07 2001, Jan 30 2007 - Mar 15 2007                                                                                                                                                                                                                |
| data.roadWinStreak             | 10                                                                                                                                                                                                                                                                  |
| data.roadWinStreakDates        | Feb 27 2001 - Apr 07 2001                                                                                                                                                                                                                                           |
| data.roadWinlessStreak         | 32                                                                                                                                                                                                                                                                  |
| data.roadWinlessStreakDates    | Nov 12 1977 - Mar 15 1978                                                                                                                                                                                                                                           |
| data.winStreak                 | 13                                                                                                                                                                                                                                                                  |
| data.winStreakDates            | Feb 26 2001 - Mar 23 2001                                                                                                                                                                                                                                           |
| data.winlessStreak             | 27                                                                                                                                                                                                                                                                  |
| data.winlessStreakDates        | Feb 12 1976 - Apr 04 1976                                                                                                                                                                                                                                           |

### Goalie Records

| data.activePlayer | data.firstName | data.franchiseId | data.franchiseName | data.gameTypeId | data.gamesPlayed | data.lastName | data.losses | data.mostGoalsAgainstDates                                 | data.mostGoalsAgainstOneGame | data.mostSavesDates    | data.mostSavesOneGame | data.mostShotsAgainstDates | data.mostShotsAgainstOneGame | data.mostShutoutsOneSeason | data.mostShutoutsSeasonIds                       | data.mostWinsOneSeason | data.mostWinsSeasonIds | data.overtimeLosses | data.playerId | data.positionCode | data.rookieGamesPlayed | data.rookieShutouts | data.rookieWins | data.seasons | data.shutouts | data.ties | data.wins |
| :---------------- | :------------- | ---------------: | :----------------- | --------------: | ---------------: | :------------ | ----------: | :--------------------------------------------------------- | ---------------------------: | :--------------------- | --------------------: | :------------------------- | ---------------------------: | -------------------------: | :----------------------------------------------- | ---------------------: | :--------------------- | ------------------: | ------------: | :---------------- | ---------------------: | ------------------: | --------------: | -----------: | ------------: | --------: | --------: |
| FALSE             | Sean           |               23 | New Jersey Devils  |               2 |              162 | Burke         |          66 | 1988-11-29                                                 |                            9 | 1988-10-10             |                    41 | 1989-11-04                 |                           44 |                          3 | 19881989                                         |                     22 | 19881989, 19891990     |                  NA |       8445769 | G                 |                     62 |                   3 |              22 |            4 |             4 |        23 |        62 |
| FALSE             | Doug           |               23 | New Jersey Devils  |               2 |               84 | Favell        |          40 | 1977-12-20                                                 |                            9 | 1976-12-19             |                    51 | 1976-12-19                 |                           55 |                          1 | 19771978                                         |                     13 | 19771978               |                  NA |       8446794 | G                 |                     NA |                  NA |              NA |            3 |             1 |        17 |        21 |
| FALSE             | Denis          |               23 | New Jersey Devils  |               2 |               86 | Herron        |          52 | 1976-03-30, 1976-03-27, 1976-01-14, 1975-02-02             |                            8 | 1976-03-27             |                    51 | 1976-03-27                 |                           59 |                          0 | 19741975, 19751976                               |                     11 | 19751976               |                  NA |       8447755 | G                 |                     22 |                   0 |               4 |            2 |             0 |        15 |        15 |
| FALSE             | Ron            |               23 | New Jersey Devils  |               2 |               81 | Low           |          43 | 1984-10-20, 1984-03-07, 1983-12-10, 1983-12-01, 1983-11-19 |                            8 | 1984-03-14             |                    43 | 1984-03-14                 |                           46 |                          1 | 19841985                                         |                      8 | 19831984               |                  NA |       8448891 | G                 |                     NA |                  NA |              NA |            3 |             1 |         9 |        16 |
| FALSE             | Peter          |               23 | New Jersey Devils  |               2 |               36 | McDuffe       |          25 | 1974-12-01                                                 |                           10 | 1975-03-30             |                    51 | 1975-03-30                 |                           59 |                          0 | 19741975                                         |                      7 | 19741975               |                  NA |       8449426 | G                 |                     NA |                  NA |              NA |            1 |             0 |         4 |         7 |
| FALSE             | Bill           |               23 | New Jersey Devils  |               2 |               22 | McKenzie      |          16 | 1975-11-02                                                 |                           10 | 1978-01-01             |                    53 | 1978-01-01                 |                           58 |                          1 | 19791980                                         |                      9 | 19791980               |                  NA |       8449491 | G                 |                     NA |                  NA |              NA |            4 |             0 |         1 |         1 |
| FALSE             | Roland         |               23 | New Jersey Devils  |               2 |                1 | Melanson      |           0 | 1991-02-27                                                 |                            2 | 1991-02-27             |                     5 | 1991-02-27                 |                            7 |                          0 | 19901991                                         |                      0 | 19901991               |                  NA |       8449547 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         0 |
| FALSE             | Lindsay        |               23 | New Jersey Devils  |               2 |                9 | Middlebrook   |           6 | 1982-11-13, 1982-10-20                                     |                            7 | 1983-02-05             |                    34 | 1983-02-05                 |                           39 |                          0 | 19821983                                         |                      0 | 19821983               |                  NA |       8449588 | G                 |                     NA |                  NA |              NA |            1 |             0 |         1 |         0 |
| FALSE             | Phil           |               23 | New Jersey Devils  |               2 |               34 | Myre          |          23 | 1982-02-02, 1981-12-23                                     |                            8 | 1982-01-10             |                    41 | 1982-01-10                 |                           46 |                          0 | 19801981, 19811982                               |                      3 | 19801981               |                  NA |       8449784 | G                 |                     NA |                  NA |              NA |            2 |             0 |         3 |         5 |
| FALSE             | Bill           |               23 | New Jersey Devils  |               2 |                1 | Oleschuk      |           1 | 1979-02-25, 1978-10-31                                     |                            8 | 1979-01-17             |                    54 | 1979-01-17                 |                           56 |                          1 | 19781979                                         |                      6 | 19781979               |                  NA |       8449978 | G                 |                     40 |                   1 |               6 |            4 |             0 |         0 |         0 |
| FALSE             | Michel         |               23 | New Jersey Devils  |               2 |               24 | Plasse        |          16 | 1978-02-18                                                 |                            9 | 1977-02-22             |                    49 | 1977-02-22, 1976-12-18     |                           51 |                          0 | 19741975, 19761977, 19771978, 19781979, 19791980 |                     12 | 19761977               |                  NA |       8450468 | G                 |                     NA |                  NA |              NA |            5 |             0 |         3 |         4 |
| FALSE             | Jeff           |               23 | New Jersey Devils  |               2 |                3 | Reese         |           2 | 1996-10-19                                                 |                            6 | 1996-10-29             |                    21 | 1996-10-19                 |                           26 |                          0 | 19961997                                         |                      0 | 19961997               |                  NA |       8450743 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         0 |
| FALSE             | Glenn          |               23 | New Jersey Devils  |               2 |               69 | Resch         |          35 | 1981-10-15                                                 |                           10 | 1984-03-10             |                    51 | 1984-03-10                 |                           57 |                          1 | 19831984                                         |                     16 | 19811982               |                  NA |       8450802 | G                 |                     NA |                  NA |              NA |            6 |             0 |        13 |        18 |
| FALSE             | Bob            |               23 | New Jersey Devils  |               2 |               49 | Sauve         |          21 | 1988-10-15, 1987-12-16                                     |                            7 | 1987-12-12             |                    40 | 1987-12-12                 |                           44 |                          0 | 19871988, 19881989                               |                     10 | 19871988               |                  NA |       8451143 | G                 |                     NA |                  NA |              NA |            2 |             0 |         4 |        14 |
| FALSE             | Peter          |               23 | New Jersey Devils  |               2 |                4 | Sidorkiewicz  |           3 | 1993-12-22                                                 |                            3 | 1994-01-15, 1993-12-15 |                    17 | 1993-12-15                 |                           19 |                          0 | 19931994, 19971998                               |                      0 | 19931994, 19971998     |                  NA |       8451369 | G                 |                     NA |                  NA |              NA |            2 |             0 |         0 |         0 |
| FALSE             | Al             |               23 | New Jersey Devils  |               2 |               36 | Smith         |          18 | 1980-12-13                                                 |                            9 | 1980-11-02             |                    37 | 1980-11-02                 |                           41 |                          0 | 19801981                                         |                      9 | 19801981               |                  NA |       8451474 | G                 |                     NA |                  NA |              NA |            1 |             0 |         4 |         9 |
| FALSE             | John           |               23 | New Jersey Devils  |               2 |                9 | Vanbiesbrouck |           3 | 2002-04-13, 2002-03-05, 2001-04-02                         |                            3 | 2002-02-27             |                    31 | 2002-02-27                 |                           32 |                          1 | 20002001                                         |                      4 | 20002001               |                  NA |       8452157 | G                 |                     NA |                  NA |              NA |            2 |             1 |         0 |         6 |
| FALSE             | Martin         |               23 | New Jersey Devils  |               2 |             1259 | Brodeur       |         394 | 2014-01-26, 2012-01-04, 2011-11-30, 2009-04-01, 2009-03-07 |                            6 | 2010-01-12             |                    51 | 2010-01-12                 |                           51 |                         12 | 20062007                                         |                     48 | 20062007               |                  49 |       8455710 | G                 |                     47 |                   3 |              27 |           21 |           124 |       105 |       688 |
| FALSE             | Richard        |               23 | New Jersey Devils  |               2 |                1 | Shulmistra    |           1 | 1998-01-01                                                 |                            2 | 1998-01-01             |                    28 | 1998-01-01                 |                           30 |                          0 | 19971998                                         |                      0 | 19971998               |                  NA |       8458932 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         0 |
| FALSE             | Kevin          |               23 | New Jersey Devils  |               2 |               25 | Weekes        |           7 | 2009-03-18, 2008-12-13, 2008-11-12, 2008-01-05, 2007-10-20 |                            4 | 2009-02-19             |                    39 | 2009-02-19                 |                           41 |                          0 | 20072008, 20082009                               |                      7 | 20082009               |                   1 |       8459463 | G                 |                     NA |                  NA |              NA |            2 |             0 |        NA |         9 |
| FALSE             | Johan          |               23 | New Jersey Devils  |               2 |               80 | Hedberg       |          29 | 2013-03-09, 2013-02-23, 2013-02-16, 2011-10-27             |                            5 | 2010-11-27             |                    40 | 2011-10-27, 2010-11-10     |                           42 |                          4 | 20112012                                         |                     17 | 20112012               |                   7 |       8460704 | G                 |                     NA |                  NA |              NA |            3 |             8 |        NA |        38 |
| FALSE             | Mike           |               23 | New Jersey Devils  |               2 |                2 | McKenna       |           1 | 2010-12-02, 2010-11-20                                     |                            3 | 2010-12-02             |                    26 | 2010-12-02                 |                           29 |                          0 | 20102011                                         |                      0 | 20102011               |                   0 |       8470093 | G                 |                     NA |                  NA |              NA |            1 |             0 |        NA |         0 |
| FALSE             | Yann           |               23 | New Jersey Devils  |               2 |               14 | Danis         |           3 | 2010-03-13                                                 |                            4 | 2009-10-29             |                    31 | 2009-10-29                 |                           32 |                          0 | 20092010, 20152016                               |                      3 | 20092010               |                   1 |       8471186 | G                 |                     NA |                  NA |              NA |            2 |             0 |        NA |         3 |
| TRUE              | Cory           |               23 | New Jersey Devils  |               2 |              311 | Schneider     |         133 | 2019-10-30, 2017-04-06, 2014-03-07                         |                            7 | 2017-10-11             |                    47 | 2017-10-11                 |                           50 |                          5 | 20142015                                         |                     27 | 20152016               |                  50 |       8471239 | G                 |                     NA |                  NA |              NA |            7 |            17 |         0 |       115 |
| FALSE             | Eddie          |               23 | New Jersey Devils  |               2 |                4 | Lack          |           2 | 2018-02-11                                                 |                            4 | 2018-02-17             |                    48 | 2018-02-17                 |                           51 |                          0 | 20172018                                         |                      1 | 20172018               |                   0 |       8475663 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         1 |
| TRUE              | Louis          |               23 | New Jersey Devils  |               2 |               16 | Domingue      |           8 | 2019-12-07                                                 |                            6 | 2020-02-18             |                    36 | 2020-02-18                 |                           39 |                          0 | 20192020                                         |                      3 | 20192020               |                   2 |       8475839 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         3 |
| TRUE              | Aaron          |               23 | New Jersey Devils  |               2 |                7 | Dell          |           5 | 2021-04-22, 2021-04-17, 2021-02-21                         |                            4 | 2021-02-21             |                    37 | 2021-02-21                 |                           41 |                          0 | 20202021                                         |                      1 | 20202021               |                   0 |       8477180 | G                 |                     NA |                  NA |              NA |            1 |             0 |         0 |         1 |
| TRUE              | Mackenzie      |               23 | New Jersey Devils  |               2 |              105 | Blackwood     |          41 | 2019-03-12                                                 |                            9 | 2020-02-16             |                    52 | 2020-02-16                 |                           55 |                          3 | 20192020                                         |                     22 | 20192020               |                  12 |       8478406 | G                 |                     47 |                   3 |              22 |            3 |             6 |         0 |        46 |

### Skater Records

### Admin History and Retired Numbers

| data.mostRecentTeamId | data.teamFullName | data.teamAbbrev | data.id | data.active | data.captainHistory | data.coachingHistory | data.dateAwarded | data.directoryUrl | data.firstSeasonId | data.generalManagerHistory | data.heroImageUrl | data.retiredNumbersSummary | total |
| --------------------: | :---------------- | :-------------- | ------: | :---------- | :------------------ | :------------------- | :--------------- | :---------------- | -----------------: | :------------------------- | :---------------- | :------------------------- | ----: |

| 12|Carolina Hurricanes |CAR | 26|TRUE |

<ul class="striped-list">

<li>

Jordan Staal: 2019-20 – Present

</li>

<li>

Justin Williams: 2018-19

</li>

<li>

Justin Faulk and Jordan Staal: 2017-18

</li>

<li>

(No Captain): 2016-17

</li>

<li>

Eric Staal: 2010-11 – 2015-16

</li>

<li>

Rod Brind’Amour and Eric Staal: 2009-10

</li>

<li>

Rod Brind’Amour: 2005-06 – 2008-09

</li>

<li>

Ron Francis: 2000-01 – 2003-04

</li>

<li>

Keith Primeau and Ron Francis: 1999-00

</li>

<li>

Keith Primeau: 1998-99

</li>

<li>

Kevin Dineen: 1996-97 – 1997-98

</li>

<li>

Brendan Shanahan: 1995-96

</li>

<li>

Pat Verbeek: 1992-93 – 1994-95

</li>

<li>

Randy Ladouceur: 1991-92

</li>

<li>

Ron Francis: 1985-86 – 1990-91

</li>

<li>

Mark Johnson and Ron Francis: 1984-85

</li>

<li>

Mark Johnson: 1983-84

</li>

<li>

Russ Anderson: 1982-83

</li>

<li>

Dave Keon: 1981-82

</li>

<li>

Rick Ley and Mike Rogers: 1980-81

</li>

<li>

Rick Ley: 1979-80

</li>

</ul>

|

<ul class="striped-list">

<li>

Rod Brind’Amour: Oct. 4, 2018 – Present

</li>

<li>

Bill Peters: Oct. 10, 2014 – April 7, 2018

</li>

<li>

Kirk Muller: Nov. 29, 2011 – April 13, 2014

</li>

<li>

Paul Maurice: Dec. 4, 2008 – Nov. 27, 2011

</li>

<li>

Peter Laviolette: Dec. 18, 2003 – Nov. 30, 2008

</li>

<li>

Paul Maurice: Nov. 7, 1995 – Dec. 14, 2003

</li>

<li>

Paul Holmgren: Jan. 21 – Nov. 5, 1995

</li>

<li>

Pierre McGuire: Nov. 17, 1993 – April 14, 1994

</li>

<li>

Paul Holmgren: Oct. 6, 1992 – Nov. 13, 1993

</li>

<li>

Jim Roberts:  Oct. 5, 1991 – May 1, 1992

</li>

<li>

Rick Ley: Oct. 5, 1989 – April 13, 1991

</li>

<li>

Larry Pleau: Feb. 7, 1988 – April 9, 1989

</li>

<li>

Jack Evans: Oct. 5, 1983 – Feb. 6, 1988

</li>

<li>

John Cunniff: March 8 – April 3, 1983

</li>

<li>

Larry Pleau: Jan. 27 – March 6, 1983

</li>

<li>

Larry Kish: Oct. 6, 1982 – Jan. 23, 1983

</li>

<li>

Larry Pleau: Feb. 22, 1981 – April 4, 1982

</li>

<li>

Don Blackburn: Oct. 11, 1979 – Feb. 19, 1981

</li>

<li>

  - <i>Date range indicates first and last games coached during tenure
    (regular season or playoffs)</i>
    </li>
    </ul>
    |1979-06-22T00:00:00 |<https://www.nhl.com/hurricanes/team/staff> |
    19791980|
    <ul class="striped-list">
    <li>
    Don Waddell: May 8, 2018 – Present
    </li>
    <li>
    Ron Francis: April 28, 2014 – March 7, 2018
    </li>
    <li>
    Jim Rutherford: June 28, 1994 – April 28, 2014
    </li>
    <li>
    Paul Holmgren: Sept. 8, 1993 – June 28, 1994
    </li>
    <li>
    Brian Burke: May 26, 1992 – Sept. 1, 1993
    </li>
    <li>
    Eddie Johnston: May 11, 1989 – May 12, 1992
    </li>
    <li>
    Emile Francis: May 2, 1983 – May 11, 1989
    </li>
    <li>
    Larry Pleau: April 2, 1981 – May 2, 1983
    </li>
    <li>
    Jack Kelley: May 6, 1977 – April 2, 1981
    </li>
    <li>
      - <em>Date range indicates first and last days of tenure</em>
        </li>
        </ul>
        |<https://records.nhl.com/site/asset/public/ext/hero/Team>
        Pages/Aho.jpg |
        <ul class="striped-list">
        <li>
        2 – Glen Wesley (1994-08)
        </li>
        <li>
        10 – Ron Francis (1981-91, 1998-04)
        </li>
        <li>
        17 – Rod Brind’Amour (2000-10)  
        </li>
        </ul>
        | 1|
