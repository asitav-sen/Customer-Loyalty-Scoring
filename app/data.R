scores<-read_fst("./data/scores.fst")
repscoresbymonth<-read_fst("./data/repscoresbymonth.fst")
repscoresdeltamonth<-read_fst("./data/repscoresdeltamonth.fst")
maxrepdeltamonth<-read_fst("./data/maxrepdeltamonth.fst")

valscoresbymonth<-read_fst("./data/valscoresbymonth.fst")
valscoresdeltamonth<-read_fst("./data/valscoresdeltamonth.fst")
maxvaldeltamonth<-read_fst("./data/maxvaldeltamonth.fst")

monthfilters<-ymd(unique(scores$monthid))

