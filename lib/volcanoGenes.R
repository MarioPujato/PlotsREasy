#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
data = as.matrix( read.table( dataFile, header = T, sep = "\t", check.names = F ))

# Fold change cutoff
fold_change_cutoff = input$fcCutoffVLC

# P value color cutoff
pvalue_cutoff      = input$pvCutoffVLC

# Set non-significant genes to 'NA'
sig_data  = data
sig_data[as.numeric(sig_data[,3])<=pvalue_cutoff] <- NA
sig_data[as.numeric(sig_data[,2])>=-fold_change_cutoff & as.numeric(sig_data[,2])<=fold_change_cutoff] <- NA
s_data    = sig_data[complete.cases(sig_data),]

if( length(s_data) == 4 ){
	    s_data = matrix(s_data,nrow=2,ncol=length(s_data),byrow=TRUE)
}
s_genes = s_data[,1]

write( s_genes, file = file )
