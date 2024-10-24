# necessary packages that need to be installed
install.packages('igraph')
install.packages('scales')

# preliminaries: loading libraries and predefined functions
library(igraph)
library(scales)
source('functions.R')

################# parameters of the model (these parameters are changeable) ###############################
n_agents = 20 
# information "impulse" between agents
influence_rate = .5
# the number of agents start with the information (=1)
have_info = n_agents*.2
# proportion network that stays connected, connectedness=1 indicates highly connected with each other, and very intensive; =0 indicates sparse connection
connectedness = 1
# number of pairwise "conversations"
rounds_of_interaction = n_agents*20
# set seed to make code reproducible
set.seed(11)

################## initialize agents, connections, and run ##############################
# initialize n_agents to 0 (rep = repeat)
agent_states = rep(0,n_agents) 
# randomly choose who starts with information
agent_states[sample(1:n_agents,have_info)] = 1 
# connections to zero out
n_delete = round((1-connectedness)*n_agents^2)
connection_matrix = make_connections(n_agents,n_delete=n_delete,type='circle') 
# add hubs in the model
connection_matrix[1,3] = 1 # make a long range (a 'hub'), further adjustment with established network from make_connections function 
connection_matrix[4,7] = 1 # make a long range (a 'hub')

#extract all the edges connected, >0 indicates having connection
edge_list = which(connection_matrix>0,arr.ind=TRUE) 
history = run_model(agent_states=agent_states,
                    edge_list=edge_list,
                    rounds_of_interaction=rounds_of_interaction,
                    influence_rate=influence_rate)

################## plots of history and average agent states #############################
colors = alpha(rainbow(n_agents),.25) #.25 indicates the transparency extent of the dots
par(mfrow=c(2,2)) #set the place to draw 2*2 indicates 4 graphs will be drawn
# Fig.1_initial state
plot_graph(connection_matrix,history[1,],colors)
# Fig.2_final state after rounds of iterations
plot_graph(connection_matrix,history[nrow(history),],colors)
#Fig.3_dynamic changes of agents
plot_history(history,colors=colors,line_width=3,
             line_type='l',y_axis_range=c(0,1))
# Fig.4_average stat of all agents as the iterations go on
plot(rowMeans(history),type='l',ylim=c(0,1),
     xlab='Iteration',ylab='Average state')

