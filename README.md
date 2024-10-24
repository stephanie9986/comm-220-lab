# Information spread among social networks
This repository contains code for building a computational model that simulates information spread within social networks. By adjusting various parameters, the code generates dynamic changes in the network's structure and behavior.
# Overview
Key parameters in the `information_spread_social_network.R` are `n_agents`, `influence_rate`, `have_info`, `connectedness` and `rounds_of_interaction`. These parameters define the initial state of social network. There is one more parameter that you can optionally add, which is the `connection_matrix`, representing the hub in social network. With this parameter, you can define which agents are directly connected to other agents in the initial state.
# Notes on running
Before running this script, please make sure that you've installed the needed packages in R (`igraph` and `scales`). You also need to put the source file `functions_social_networks.R` in the same directory as the main code `information_spread_social_network.R`.

If you want to make your results reproducible, please set a random seed by using the `set.seed()` function before running your code.
