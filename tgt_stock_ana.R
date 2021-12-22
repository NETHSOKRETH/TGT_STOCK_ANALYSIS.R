library(quantmod) # install quantmod for data retrieving
library(ggplot2) # install ggplot2 for data visualization
library(magrittr) # install magrittr for %>% function
library(broom) # install broom for tidy function

# Create start and end date variable
start = as.Date('2020-12-12')
end = as.Date('2021-12-20')

# Retrieve dataset and put into table format
getSymbols('TGT', src = 'yahoo', from = start, to = end)
write.zoo(TGT, 'TGT_Dataset.csv', sep = ',')

# Filter only important variable(column) and put into new table
adjusted_stocks = as.xts(data.frame(A = TGT[, 'TGT.Adjusted']))

write.csv(adjusted_stocks, "C:/Users/NethSokreth/Documents/TGT_Adjusted.csv")

# Perform the visualization(ggplot2)
Target_stocks = tidy(adjusted_stocks) %>%
  ggplot(aes(x=index,y=value)) +
  xlab('Date') + ylab('Price ($)') +
  geom_line(size = 1, colour = "Green") +
  geom_area(fill = 'Green', alpha = 0.05) +
  labs(
    subtitle = "Range: Dec/12/2020 - Dec/12/2021",
    caption = "By: Neth Sokreth"
  ) + 
  ggtitle("Target Corporate Stock Prices") + theme(
    plot.title = element_text(hjust = 0.5, size = 20, color = "DarkGreen", face = "bold"))

# Call ggplot
Target_stocks