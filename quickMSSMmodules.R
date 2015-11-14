foo <- synGet('syn5259774')
load(foo@filePath)
require(igraph)
g = igraph::graph.adjacency(sparseNetwork, mode = 'undirected', weighted = T, diag = F)
mod = igraph::fastgreedy.community(g)

combinedMod <- data.frame(geneName = mod$names,metanetworkModuleFP = mod$membership,stringsAsFactors = F)


foo <- synGet('syn5264095')
load(foo@filePath)
require(igraph)
g = igraph::graph.adjacency(sparseNetwork, mode = 'undirected', weighted = T, diag = F)
mod = igraph::fastgreedy.community(g)

combinedMod$metanetworkModuleSTG = mod$membership


foo <- synGet('syn5259844')
load(foo@filePath)
require(igraph)
g = igraph::graph.adjacency(sparseNetwork, mode = 'undirected', weighted = T, diag = F)
mod = igraph::fastgreedy.community(g)

combinedMod$metanetworkModulePHG = mod$membership

write.csv(combinedMod,file='metanetworkModulesMSSM.csv',quote=F)




