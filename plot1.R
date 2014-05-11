source( 'common.R' )

png( filename='plot1.png', width=504, height=504, bg='transparent' )
hist( filtered$Global_active_power,
      xlab='Global Active Power (kilowatts)',
      main='Global Active Power', col='Red' )
dev.off()
