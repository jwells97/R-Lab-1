#Jason Wells
#10/7/2019
#Lab 5a
library(tidyverse)
library(rvest)
library(robotstxt)
paths_allowed("https://www.metacritic.com/")
page <- read_html("https://www.metacritic.com/browse/games/score/metascore/year/all/")
title <- page %>%
  html_nodes("#main .product_title") %>%
  html_text()
url <- page %>%
  html_nodes("#main .product_title a") %>%
  html_attr("href")
title <- title %>%
  str_replace("\\n", "") %>%
  str_replace_all("\\s", "")
url2 <-   paste0("https://www.metacritic.com", url )
meta_rates <- page %>%
  html_nodes("#main .positive") %>%
  html_text()
user_score <- page %>%
  html_nodes("#main .textscore") %>%
  html_text()
oneURL <- url2[1]
print(oneURL)
page2 <- read_csv("data/videoGames.csv")
videoGames_noGenre <- page2 %>%
  select(metaCritic, userScore)
videoGames_noGenre %>%
  ggplot(mapping = aes(x = metaCritic, y = userScore)) +
  geom_point()
videoGames_noGenre %>%
  summarise(r = cor(x = metaCritic, y = userScore))
# A tibble: 1 x 1
#r
#<dbl>
#  1 0.308
#This surprisingly low value astonished me.
videoGames <- read_csv("data/videoGames.csv")
new_videoGames <- videoGames$genre %>%
  str_remove("Genre\\(s\\)\\:") %>%
  trimws()
view(url2)
view(title)
view(new_videoGames)
