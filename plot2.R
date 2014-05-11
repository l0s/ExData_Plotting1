source( 'common.R' )

png( filename='plot2.png', width=504, height=504, bg='transparent' )
with( filtered,
      plot( Global_active_power ~ timestamp, type='l',
            ylab='Global Active Power (kilowatts)',
            xlab='' ) )
dev.off()
