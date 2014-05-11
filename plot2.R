# TODO dl file
# TODO unzip file
consumption <-
  read.csv( 'household_power_consumption.txt', header=TRUE, sep=';',
            colClasses=c( 'character', 'character', 'numeric', 'numeric',
                          'numeric', 'numeric', 'numeric', 'numeric',
                          'numeric' ), na.strings='?' )
consumption$timestamp <-
  as.POSIXct( paste( consumption$Date, consumption$Time, sep=' ' ),
              format='%d/%m/%Y %H:%M:%S', tz='UTC' )
#consumption$timestampMillis <- as.numeric( consumption$timestamp )
consumption$Date <- as.Date( consumption$Date, format='%d/%m/%Y' )

iso86001 <- '%Y-%m-%dT%H:%M:%S'
lowerBound <-
  as.POSIXct( '2007-02-01 00:00:00', format=iso86001 )
upperBound <-
  as.POSIXct( '2007-02-03 00:00:00', format=iso86001 )
#filtered <-
  #consumption[ consumption$Date >= as.Date( '2007-02-01' )
               #& consumption$Date < as.Date( '2007-02-03' ), ]
filtered <-
  consumption[ consumption$timestamp >= as.POSIXct( '2007-02-01', tz='UTC' )
               & consumption$timestamp < as.POSIXct( '2007-02-03', tz='UTC' ), ]
png( filename='plot2.png', width=504, height=504, bg='transparent' )
with( filtered,
      plot( Global_active_power ~ timestamp, type='l',
            ylab='Global Active Power (kilowatts)',
            xlab='' ) )
dev.off()
