mean_lifeExp_by_continent <- function(gpmndr) {
    gpmndr %>%
        group_by(year, continent) %>%
        summarize(
            mean_lifeExp = mean(lifeExp)
        )
}

plot_mean_lifeExp <- function(gpmndr_continent) {
    ggplot(gpmndr_continent, aes(x = year, y = mean_lifeExp, group = continent, colour = continent)) +
        geom_line() +
        xlab("Year") + ylab("Mean life expectancy")
}

plot_by_country <- function(gpmndr, countries = c("South Africa", "Morocco", "Algeria", "Nigeria")) {

    not_found <- countries[! countries %in% unique(gpmndr[["country"]])]
    if(length(not_found) > 0) {
        stop(paste(not_found, collapse = ", "),
             " not found in the gapminder data.")
    }

    gpmndr %>%
        filter(country %in%  countries) %>%
        ggplot(aes(x = year, y = lifeExp, colour = country, group = country)) +
        geom_line() +
        facet_wrap(~ country) +
        xlab("Year") + ylab("Life Expectancy")
}
