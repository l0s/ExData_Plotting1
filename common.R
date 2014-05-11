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
  filtered <-
    consumption[ consumption$timestamp >= as.POSIXct( '2007-02-01',
                                                      tz='UTC' )
                & consumption$timestamp < as.POSIXct( '2007-02-03',
                                                      tz='UTC' ), ]
  save( filtered, file=filteredDf )
}
# this creates a Data Frame called 'filtered'
load( filteredDf )
