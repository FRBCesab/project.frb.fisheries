##############################################################
# 2/12/2021
# Lola Gilbert
#
# update_description.R
# techniques to update description with packages use
#############################################################


# three solutions

# one by hand
x <- renv::dependencies()
paste0(sort(unique(x$Package)), collapse = ", ")
# and then copy and paste in description

# one automatic with Nicolas Casajus package
rcompendium::add_dependencies()

# one automatic with package attachment but
# it looks like some are missing
# attachment::att_amend_desc()
