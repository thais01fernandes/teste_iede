
library("tidyverse")
library("ggplot2")
library("readxl")
library("reactable")

microdados_ed_basica_2021 <- 
  read_delim("~/teste_iede/microdados_ed_basica_2021.csv", 
                                        delim = ";", escape_double = FALSE, locale = locale(encoding='latin1'))

dados_internet <- microdados_ed_basica_2021 %>% 
  mutate(IN_INTERNET = gsub(pattern = "0",replacement = "Não", x = IN_INTERNET)) %>% 
  mutate(IN_INTERNET = gsub(pattern = "1",replacement = "Sim", x = IN_INTERNET)) %>% 
  mutate_if(is.character, ~replace(., is.na(.), "Sem resposta")) %>% 
  filter(IN_INTERNET != "Sem resposta") %>% 
  group_by(SG_UF, IN_INTERNET) %>% 
  tally() %>% 
  mutate(pct = n/sum(n)) 

write.csv(dados_internet, "dados_limpos")
