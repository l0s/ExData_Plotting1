source( 'common.R' )

png( filename='plot4.png', width=504, height=504, bg='transparent' )
split.screen( c( 2, 2 ) )
screen( 1 )
plotGlobalActivePowerVsTime( units=FALSE )
screen( 2 )
with( filtered, plot( Voltage~timestamp, xlab='datetime', type='l' ) )
screen( 3 )
plotEnergySubMeteringVsTime( legendBorder=FALSE )
screen( 4 )
with( filtered,
      plot( Global_reactive_power~timestamp, xlab='datetime', type='l' ) )
dev.off()
