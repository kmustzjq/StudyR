xc<-function(a,b){
  i=1
  while (i<a) {
    S=prod(1:i)
    i=i+1
  }
  print(S+b)
}
xc(5,3)