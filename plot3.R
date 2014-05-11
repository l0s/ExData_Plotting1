source( 'common.R' )

png( filename='plot3.png', width=504, height=504, bg='transparent' )
verticalScale <-
  range( c( filtered$Sub_metering_1, filtered$Sub_metering_2,
            filtered$Sub_metering_3 ) )
with( filtered, {
  plot( Sub_metering_1 ~ timestamp, type='l', col='black',
        ylim=verticalScale, xlab='', ylab='' )
  plot( Sub_metering_2 ~ timestamp, type='l', col='red',
        ylim=verticalScale, xlab='', ylab='' )
  plot( Sub_metering_3 ~ timestamp, type='l', col='blue',
        ylim=verticalScale, xlab='', ylab='Energy sub metering' )
  legend( 'topright', col=c( 'black', 'red', 'blue' ),
          legend=c( 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3' ),
          lwd=1 )
} )
dev.off()
