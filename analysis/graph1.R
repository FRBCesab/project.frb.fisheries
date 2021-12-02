###########################################
#
#
#file name = graph1.r
#
#graph with to Y axis
###########################################

ggplot(data, aes(x=year)) +

  geom_line( aes(y=tonnage)) +
  geom_line( aes(y=C)) +

  scale_y_continuous(

    # Features of the first axis
    name = "Tonnage",

    # Add a second axis and specify its features
    sec.axis = sec_axis(XXX, name="C,N,P")
  )
