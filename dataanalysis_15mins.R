# A 15-minute data analysis using dplyr, ggplot2, and HairEyecolor data set.  
# Use install.packages("dplyr") and install.packages("ggplot2") if not installed.  
library("dplyr")
library("ggplot2")

# HaireEyeColor data set built into R  
# Originally table, need to convert to dataframe
data_eyecolor <- as_data_frame(HairEyeColor)

# Boring graph
data_eyecolor %>% 
  ggplot() +
  geom_point(aes(x = Hair,
                 y = n,
                 color = Eye)) +
  facet_grid(~Sex) +
  labs(title = "Frequency of eye color by hair color and sex")

# Want to use colors so visualization is more accessible 
eye_color_vec <- c("Blue",
                   "#9e6b4a", # Brown
                   "Green",
                   "#cbce86") # Hazel

hair_color_vec <- c("Black",
                    "Yellow", # Blond is too hard to see on screen
                    "Brown",
                    "Red")

# Want to remove the x-axis title without loss of information
# Will replace "color" with "color hair"
data_eyecolor %>% mutate(Hair = paste0(Hair, " Hair")) 


# Putting everything together
data_eyecolor %>% 
  mutate(Hair = paste0(Hair, " Hair")) %>% 
  ggplot() +
  geom_point(aes(x = Hair,
                 y = n,
                 color = Eye),
             size = 3) +
  facet_grid(~Sex) +
  labs(title = "Frequency of eye color by hair color and sex") +
  theme(axis.text.x = element_text(colour = hair_color_vec)) + # set text to hair_color_vec
  scale_colour_manual(values = eye_color_vec) + # set points color to eye_color_vec
  theme(legend.position="none", # removes legend  
        axis.title.y=element_blank(), # removes y-axis title
        axis.title.x = element_blank(), # removes x-axis title
        strip.text.x = element_text(size = 11), # Increases facet title size
        plot.title = element_text(size=22, # increases title size
                                  hjust = 0.5)) #centers title

# Do Females with Red Hair and Blue Eyes not exist?  
data_eyecolor %>% 
  filter(Sex == "Female" & Hair == "Red") %>% 
  head()

# Opps!  So some points are overlapping.  
# Replace geom_point with geom_jitter
data_eyecolor %>% 
  mutate(Hair = paste0(Hair, " Hair")) %>% 
  ggplot() +
  geom_jitter(aes(x = Hair,
                 y = n,
                 color = Eye),
             size = 3,
             width = .1) +
  facet_grid(~Sex) +
  labs(title = "Frequency of eye color by hair color and sex") +
  theme(axis.text.x = element_text(colour = hair_color_vec)) + # set text to hair_color_vec
  scale_colour_manual(values = eye_color_vec) + # set points color to eye_color_vec
  theme(legend.position="none", # removes legend  
        axis.title.y=element_blank(), # removes y-axis title
        axis.title.x = element_blank(), # removes x-axis title
        strip.text.x = element_text(size = 11), # Increases facet title size
        plot.title = element_text(size=22, # increases title size
                                  hjust = 0.5)) #centers title

# End  