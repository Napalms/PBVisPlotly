source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly")
####################################################

################### Actual code ####################

library(ggplot2)
library(plotly)


dataset$OutOfSpecAmt = dataset$'Avg Out Of Spec Amt'

dataset <- dataset[ , !(names(dataset) %in% 'Avg Out Of Spec Amt')]

dataset$Row <- as.numeric(dataset$Row)
dataset$Position <- as.numeric(dataset$Position)
dataset$Level <- as.numeric(dataset$Level)


fig <- plot_ly(dataset, x = ~Row, y = ~Position, z = ~Level, opacity=0.99,
               marker = list(color = ~OutOfSpecAmt, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE))
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'Row'),
                                   yaxis = list(title = 'Position'),
                                   zaxis = list(title = 'Level', rangemode = 'tozero'))
                      
)

####################################################

############# Create and save widget ###############
internalSaveWidget(fig, 'out.html');
####################################################

################ Reduce paddings ###################
ReadFullFileReplaceString('out.html', 'out.html', ',"padding":[0-9]*,', ',"padding":0,')
####################################################
