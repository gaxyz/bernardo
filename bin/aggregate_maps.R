library(tidyverse)


files <- list.files(pattern = "\\.map$")
cnames <- c("rs","chr","cM","pos","ldu")
ctypes <- cols( 
      rs = col_character(), 
      chr = col_double(), 
      cM = col_double(), 
      pos = col_double(), 
      ldu = col_double() 
    ) 


counter <- 0
for ( i in files ){
	counter <- counter + 1
	pop <- tools::file_path_sans_ext(i)
	
	if ( counter == 1 ){
		final <- read_csv(i, 
				  col_names = cnames, 
				  col_types = ctypes, 
				  skip = 1) %>%
			mutate(pop=pop)
	}else{
		tmp <- read_csv(i, 
                                  col_names = cnames, 
                                  col_types = ctypes, 
                                  skip = 1) %>%
                        mutate(pop=pop)
		final <- full_join(final,tmp)

}
}
final <- final %>% 
	select(-cM) 
final$pop <- factor(final$pop)
final$chr <- factor(final$chr)

final <- final %>% 
	na.omit() %>%
       	group_by(pop) %>% 
	mutate( cs_ldu = cumsum(ldu))


# plot tracks
pdf("ldu_tracks.pdf",width=10, height = 30)
final %>% 	

	ggplot(aes(x=pos,y=ldu, color = pop )) +
	geom_point(size=0.3,alpha=0.3)+
	geom_path()+
	facet_wrap(~pop, ncol = 1 ) +
	theme_light()


dev.off()

pdf("cumulative_ldu.pdf")
final %>% 
        ggplot(aes(x=pos,y=cs_ldu, color = pop )) +
        geom_point(size=0.3,alpha=0.3)+
        geom_path()+
        theme_light()

dev.off()

