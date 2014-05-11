workingDirectory <- 'work'
filteredDf <- paste( c( workingDirectory, 'filtered.rda' ), collapse='/' )
dataFile <-
  paste( c( workingDirectory, 'household_power_consumption.txt' ),
         collapse='/' )
compressedFile <-
  paste( c( workingDirectory, 'household_power_consumption.zip' ),
        collapse='/' )
dataUrl <-
  'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if( !file.exists( workingDirectory ) )
{
  dir.create( file.path( '.', workingDirectory ) )
}
if( !file.exists( filteredDf ) )
{
  if( !file.exists( dataFile ) )
  {
    if( !file.exists( compressedFile ) )
    {
      download.file( dataUrl, destfile=compressedFile, method='curl' )
    }
    unzip( compressedFile, exdir=workingDirectory )
  }
  consumption <-
    read.csv( dataFile, header=TRUE, sep=';',
              colClasses=c( 'character', 'character', 'numeric', 'numeric',
                            'numeric', 'numeric', 'numeric', 'numeric',
                            'numeric' ), na.strings='?' )
  consumption$timestamp <-
    as.POSIXct( paste( consumption$Date, consumption$Time, sep=' ' ),
                format='%d/%m/%Y %H:%M:%S', tz='UTC' )
  consumption$Date <- as.Date( consumption$Date, format='%d/%m/%Y' )
  # Per the instructions, we only care about data from the dates
  # 2007-02-01 and 2007-02-02
  filtered <-
    consumption[ consumption$timestamp >= as.POSIXct( '2007-02-01',
                                                      tz='UTC' )
                & consumption$timestamp < as.POSIXct( '2007-02-03',
                                                      tz='UTC' ), ]
  save( filtered, file=filteredDf )
}
# this creates a Data Frame called 'filtered'
load( filteredDf )

# Plot 2 and top-left figure of plot 4
plotGlobalActivePowerVsTime <- function( units=TRUE )
{
  label <- 'Global Active Power'
  if( units )
  {
    label <- paste( c( label, '(kilowatts)' ), collapse=' ' )
  }
  with( filtered,
        plot( Global_active_power ~ timestamp, type='l',
              ylab=label,
              xlab='' ) )
}

# Plot 3 and bottom-left figure of plot 4
plotEnergySubMeteringVsTime <- function( legendBorder=TRUE )
{
  verticalScale <-
    range( c( filtered$Sub_metering_1, filtered$Sub_metering_2,
              filtered$Sub_metering_3 ) )
  borderSpecifier <- ifelse( legendBorder, 'o', 'n' )
  with( filtered, {
    plot( Sub_metering_1 ~ timestamp, type='l', col='black',
          ylim=verticalScale, xlab='', ylab='' )
    plot( Sub_metering_2 ~ timestamp, type='l', col='red',
          ylim=verticalScale, xlab='', ylab='' )
    plot( Sub_metering_3 ~ timestamp, type='l', col='blue',
          ylim=verticalScale, xlab='', ylab='Energy sub metering' )
    legend( 'topright', col=c( 'black', 'red', 'blue' ),
            legend=c( 'Sub_metering_1', 'Sub_metering_2',
                      'Sub_metering_3' ),
            lwd=1, bty=borderSpecifier )
  } )
}
