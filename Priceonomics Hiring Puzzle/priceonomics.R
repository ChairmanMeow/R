#Priceonomics Hiring Puzzle
#Victor Wong 6-18-2013
#
#This R scipt is used to determine the maximum arbitrage and path given
#current exchange rates as given by the Priceonomics API at
#http://fx.priceonomics.com/v1/rates/
#The full intro to the puzzle is at: http://priceonomics.com/jobs/puzzle/
#
#My implementation involves using the Floyd-Warshall Algorithm.
#
#The function findMaxArbitrage returns the rate of return and the path of
#the best opportunities. The best opportunities are defined as the paths
#that return the highest rate of return in the given number of trade paths.


library(RCurl)
library(rjson)
library(igraph)


getData <- function(urlPath){
  rawData <- fromJSON(getURL(urlPath))
  Rates <- as.numeric(unlist(rawData))
  currencies <- names(unlist(rawData))
  
  #Split the currencies into "To" and "From" currencies
  Cname <- strsplit(currencies,"_")
  From <- sapply(Cname,function(x){x[[1]][1]})
  To <- sapply(Cname,function(x){x[[2]][1]})
  
  #Combine into matrix and then into a dataframe.
  matrix <- cbind(From, To, Rates)
  currency.df <- as.data.frame(matrix)
  
  #Convert the Rates to numeric
  currency.df$Rates <- as.numeric(levels(currency.df$Rates))[currency.df$Rates]
  
  return(currency.df)
}


#Makes the igraph plot
makeGraph <- function(dataFrame){
  currency.network <- graph.data.frame(dataFrame, directed=T)
  #V(currency.network) #Prints the list of vertices (currencies)
  #E(currency.network) #prints the list of edges (relationships)
 return( plot(currency.network) )
}


#Runs the Floyd Warshall Alogirthim to find the maximum arbitrage
#Returns 2 matrices on the gain at each step and the path needed for all values.
floydWarshall <- function(dataFrame){
  currency.network <- graph.data.frame(dataFrame, directed=T)
  #create adjanceny matrix
  adj <- as.matrix(get.adjacency(currency.network,attr='Rates'))
  nodes <- length(V(currency.network))
  rates <- array(rep(0, nodes^3), dim=c(nodes, nodes, nodes))
  path <- array(rep(rep(1:4,4), nodes), dim=c(nodes, nodes, nodes))
  rates[, , 1] <- adj
  
  for (s in 2:nodes){
  for (k in 1:nodes){
    for (i in 1:nodes){
      for (j in 1:nodes){
        hld <- rates[i, k, s-1]*rates[k,j, 1]
        if(hld>rates[i,j,s]){
          rates[i,j,s] <- hld
          path[i,j,s] <- k
        }   
        }
      }
    }
  }
  return (list(rates,path,adj))
}


findPath <- function(path, initialLocation, adj, tradeLength){
  #initialize values
  To <- From <- initialLocation 
  totalPath <- rownames(adj)[initialLocation]
    
  for(k in tradeLength:1){
  currencyPath <- path[To, From, k]
  totalPath <- c(totalPath,rownames(adj)[currencyPath])
  From <- currencyPath
  }
  
  #Clean Path to remove duplicates
  for(k in 1:(length(totalPath)-1)){
    if(totalPath[k+1]==totalPath[k]){
      totalPath[k]=NA
    }
  }
  
  totalPath <- na.omit(totalPath)
      
  return(totalPath)
}


findMaxArbitrage <- function(dataframe, tradeLength){
  rates <- floydWarshall(currency.df)[[1]]
  path <- floydWarshall(currency.df)[[2]]
  adj <- floydWarshall(currency.df)[[3]]
  
  max <- 1
  location <- 1
  
  for(k in 1:4){
    #Finds the first occurence, ignore ties.
    if (rates[k,k,tradeLength]>max){
      max <- rates[k,k,tradeLength]
      location <- k
    }
  }
  
  thePath <- findPath(path,location, adj, tradeLength)
  
  return (list(max, thePath))
  #return(thePath)
}

#######################################################################
#Perform one run of the script
urlPath <- "http://fx.priceonomics.com/v1/rates/"
currency.df <- getData(urlPath)
makeGraph(currency.df)
findMaxArbitrage(currency.df,3)
