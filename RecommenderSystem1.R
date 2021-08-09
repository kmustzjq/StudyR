## recommenderlab system

library(recommenderlab,warn.conflicts = F)
data(MovieLense)
r <- sample(MovieLense ,943,replace = F )
image (MovieLense)



Recommender()

recommenderRegistry


recommenderRegistry$get_entry_names()



r_recom <- Recommender(r,method = "IBCF")
r_popul <- Recommender(r,method = "POPULAR")


pred <- predict (r_popul,r[940:943],n = 5) 
as ( pred , "list" )
pred3 <- bestN ( pred , n = 3 )
as ( pred3 , "list" )



#评分预测
rate <- predict (r_popul,r[940:943],type = "ratings" )
as (rate,"matrix")[,1:5]


e <- evaluationScheme(r[1:800],method = "split",train = 0.9,given = 15,goodRating = 5 )
e


r1<-Recommender(getData(e,"train"),"UBCF");
p1<-predict(r1,getData(e,"known"),type="ratings");
r2<-Recommender(getData(e,"train"),"IBCF");
p2<-predict(r2,getData(e,"known"),type="ratings");


c1<-calcPredictionAccuracy(p1,getData(e,"unknown"))
c2<-calcPredictionAccuracy(p2,getData(e,"unknown"))
error<-rbind(c1,c2)
rownames(error)<-c("UBCF","IBCF")









set.seed(2016)
scheme<-evaluationScheme(r,method="split",train=0.9,k=1,given=10,goodRating=5)
#构建推荐算法列表
algorithms<-list(
  "randomitems"=list(name="RANDOM",param=NULL),"popularitems"=list(name="POPULAR",param=list(normalize="Z-score")),"user-basedCF"=list(name="UBCF",param=list(normalize="Z-score",method="Cosine",nn=25,minRating=3)),"item-basedCF"=list(name="IBCF",param=list(k=50)),"SVDapproximation"=list(name="SVD",param=list(approxRank=50)))
#构建不同算法模型
results<-evaluate(scheme,algorithms,n=c(1,3,5,10,15,20))
#模型比较#ROC曲线
plot(results,annotate=c(1,3),legend="bottomright")






head(movie_data)




ratings_movies_norm <- normalize(ratings_movies)


eval_sets <- evaluationScheme(data = ratings_movies_norm,
                              method = "cross-validation",
                              k = 10,
                              given = 5,
                              goodRating = 0)
models_to_evaluate <- list(
  `IBCF Cosinus` = list(name = "IBCF", 
                        param = list(method = "cosine")),
  `IBCF Pearson` = list(name = "IBCF", 
                        param = list(method = "pearson")),
  `UBCF Cosinus` = list(name = "UBCF",
                        param = list(method = "cosine")),
  `UBCF Pearson` = list(name = "UBCF",
                        param = list(method = "pearson")),
  `Zufälliger Vorschlag` = list(name = "RANDOM", param=NULL)
)
n_recommendations <- c(1, 5, seq(10, 100, 10))
list_results <- evaluate(x = eval_sets, 
                         method = models_to_evaluate, 
                         n = n_recommendations)



vector_nn <- c(5, 10, 20, 30, 40)
models_to_evaluate <- lapply(vector_nn, function(nn){
  list(name = "UBCF",
       param = list(method = "pearson", nn = vector_nn))
})
names(models_to_evaluate) <- paste0("UBCF mit ", vector_nn, "Nutzern")
list_results <- evaluate(x = eval_sets, 
                         method = models_to_evaluate, 
                         n = n_recommendations)



