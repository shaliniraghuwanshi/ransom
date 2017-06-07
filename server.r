library(shiny)
library(rminer)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
  
  dataa<-read.csv("C:/Users/shalu/Downloads/final/rans1.csv", na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")
  
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated
  # (i.e. whenever the input$dataset changes)
  output$summary <- renderPrint({
    #summary(dataa)
  })
  
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so will be re-executed whenever
  # input$dataset or input$obs is changed. 
  output$view <- renderTable({
    set.seed(62433)
    dataa[sample(nrow(dataa), size = input$obs),]
  })
  
  # By declaring datasetInput as a reactive expression we ensure 
  # that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers 
  #    (it only executes a single time)
  #
  algorithmInput <- reactive(input$algorithm)
  
  output$results <- renderPrint({
    
    
    # split in training testing datasets
    trainIndex <- sample(nrow(dataa), size = nrow(dataa)*input$slidertrainsplit)
    training = dataa[trainIndex,]
    testing = dataa[-trainIndex,]
    
    # apply selected classification algorithm
    if(algorithmInput()=="rpart") {
      
      # print classification parameters
      print("Algorithm selected: rpart")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build rpart model
      library(rpart)
      set.seed(12345)
      model <- rpart(nature ~ . , data= dataa)
      output$map<-renderPlot({
        plot(testing$nature)
      })
      output$stats<-renderPrint({
        print(summary(pred))
        
      })
      
      # test rpart model
      pred <- predict(model, testing, type  = "class")
     print(table(predicted = pred, reference = testing$nature))
      
      # print model
      #summary(model)
    
      
      
      
       mmetric(testing$nature,pred,c("ACC","PRECISION"))
       } else if(algorithmInput()=="randomForest") {
      
      # print classification parameters
      print("Algorithm selected: randomForest")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build randomForest model
      library(randomForest)
      library(rpart)
      set.seed(12345)
      model <- rpart(nature ~ . , data= dataa)
      output$map<-renderPlot({
        plot(testing$nature)
      })
      output$stats<-renderPrint({
        print(summary(pred))
        
      })
      
      # test randomForest model
      pred <- predict(model, testing, type  = "class")
      #print(table(predicted = pred, reference = testing$nature))
      mmetric(testing$nature,pred,c("ACC","PRECISION"))
      
      
     #  print model
   # summary(model)
      
      
    } else if(algorithmInput()=="lda") {
      
      
      # print classification parameters
      print("Algorithm selected: lda")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build lda model
      library(MASS)
      library(lda)
      set.seed(62433)
      model <- lda(nature ~ . , data= dataa)
      output$map<-renderPlot({
        plot(testing$nature)
      })
      output$stats<-renderPrint({
        print(summary(pred))
        
      })
      
      # test lda model
      pred <- predict(model, testing, type  = "class")
     # print(table(predicted = pred$class, reference = testing$nature))
      
      # print model
      #summary(model)      
      
    }else if(algorithmInput()=="naivebayes") {
      
      
      # print classification parameters
      print("Algorithm selected: naivebayes")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build naivebayes
      library(e1071)
      set.seed(62433)
      model <- naiveBayes(nature ~ . , data= dataa)
      output$map<-renderPlot({
        plot(testing$nature)
      })
      output$stats<-renderPrint({
        print(summary(pred))
        
      })
      
      # test naivebayes model
      pred <- predict(model, testing, type  = "class")
      #print(table(predicted = pred, reference = testing$nature))
      
      # print model
      summary(model)      
      mmetric(testing$nature,pred,c("ACC","PRECISION"))
    } 
    else if(algorithmInput()=="logestic") {
      
      print ("classification parameters")
      print("Algorithm selected: logestic")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build randomForest model
      library(nnet)
      set.seed(123)
    
      #model=glfit(trainingdata$nature~.,data=trainingdata)
      #glfit<-glm(trainingdata$nature~., data=trainingdata, family = 'binomial')
      
      model<- multinom(trainingdata$nature~., data=trainingdata)
      
    
      prediction=predict(model,testingdata)
      mmetric(testingdata$nature,prediction,c("ACC","PRECISION"))
      
      output$map<-renderPlot({
        plot(testing$nature)
      })
     
      
      # test randomForest model
      pred <- predict(model, testing, type  = "class")
      #print(table(predicted = pred, reference = testing$nature))
      mmetric(testing$nature,pred,c("ACC","PRECISION"))
    }
    else if(algorithmInput()=="Decision tree") {
      
      
      # print classification parameters
      print("Algorithm selected: Decision tree")
      print(paste("Training set: ", input$slidertrainsplit*100, "%", sep = ""))
      print(paste("Testing set: ", (1-input$slidertrainsplit)*100, "%", sep = ""))
      
      # build decision tree
      library(rpart)
      library(party)
      library(rpart.plot)
      library(rminer)
      library(e1071)
      set.seed(62433)
      sub=sample(seq_len(aRow),size = smple_size)
      trainingdata=datafile[sub,]
      testingdata=datafile[-sub,]
      model=rpart(trainingdata$nature~.,data=trainingdata)
      rpart.plot(model)
      clas=ctree(trainingdata$nature~.,data=trainingdata)
      plot(clas)
      prediction=predict(model,testingdata)
      mmetric(testingdata$nature,prediction,c("ACC","PRECISION"))
   } else{
      print("Error no Algorithm selected")
   }
    #clas=ctree(trainingdata$nature~.,data=trainingdata)
    
    
  }) 
  
  
  output$compare<-renderPlot({
    library(reshape2)
    setwd("C:/Users/shalu/Downloads/final")
    df=read.csv("result.csv")
    dfm=melt(df,id.vars='X')
    ResultAcc =dfm[which(dfm$variable=="acc"),]
    ResultPre1=dfm[which(dfm$variable=="pre1"),]
    ResultPre2=dfm[which(dfm$variable=="pre2"),]
    ResultPre3=dfm[which(dfm$variable=="pre3"),]
    ResultPre4=dfm[which(dfm$variable=="pre4"),]
    ResultPre5=dfm[which(dfm$variable=="pre5"),]
    res=cbind(ResultAcc[,3],ResultPre1[,3],ResultPre2[,3],ResultPre3[,3],ResultPre4[,3],ResultPre5[,3])
    colnames(res)=c("Accuracy","Precision1","Precision2","Precision3","Precision4","Precision5")
    rownames(res)=ResultPre1$X
    barplot(t(res),beside=T,ylab="%",legend.text = TRUE,args.legend = list("topright",x=15,y=160,bty='n'),ylim=c(0,150),col=c("orange","blue","red","green","pink","steelblue"),main="")
  }) 
  
  output$best<-renderPlot({
    library(reshape2)
    setwd("C:/Users/shalu/Downloads/final")
    df=read.csv("best.csv")
    dfm=melt(df,id.vars='X')
    ResultAcc =dfm[which(dfm$variable=="acc"),]
    
    res=cbind(ResultAcc[,3])
    colnames(res)=c("Accuracy")
    rownames(res)=ResultAcc$X
    barplot(t(res),beside=T,ylab="%",legend.text = TRUE,args.legend = list("topright",x=15,y=160,bty='n'),ylim=c(98,100),col=c("red"),main="")

})
})


