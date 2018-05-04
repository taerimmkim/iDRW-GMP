library(KEGGgraph)
library(igraph)
library(ggplot2)
library(annotate)
library(org.Hs.eg.db)

sapply(file.path("utils",list.files("utils", pattern="*.R")),source)

# make directory
datapath <- file.path('data')
if(!dir.exists(datapath)) dir.create(datapath)

respath <- file.path('result')
if(!dir.exists(respath)) dir.create(respath)

# read rda data
graphpath <- file.path(datapath,'directGraph.rda')
if(!file.exists(graphpath)) {
  cat('directGraph and pathSet do not exist, now creating directGraph and pathSet is start')
  cons_graph(datapath)
}
load(file.path(graphpath))
load(file.path(datapath, 'pathSet.rda'))

ppipath <- file.path(datapath, 'ppiGraph.rda')
if(!file.exists(ppipath)) {
  cat('ppiGraph does not exist, now creating ppiGraph start')
  cons_ppi(datapath)
}
load(file.path(ppipath))


g <- directGraph
m <- directGraph
p <- ppiGraph


# imputation ppi node value by using RPPA profile

rppapath <- file.path(datapath, 'mean_imputed_rppa.csv')

if(!file.exists(rppapath)) {
  cat('preprocessed rppa profile does not exist, now preprocessing RPPA profile start')
  rawrppapath <- file.path(datapath, 'brca_rppa.txt')
  preprcs_rppa(datapath, rawrppapath)
}

p <- imput_ppi(datapath, rppapath, ppiGraph)


















