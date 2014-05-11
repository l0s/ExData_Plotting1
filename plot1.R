# TODO dl file
# TODO unzip file
consumption <-
  read.csv( 'household_power_consumption.txt', header=TRUE, sep=';',
            colClasses=c( 'character', 'character', 'numeric', 'numeric',
                          'numeric', 'numeric', 'numeric', 'numeric',
                          'numeric' ), na.strings='?' )
consumption$Date <- as.Date( consumption$Date, '%d/%m/%Y' )
filtered <-
  consumption[ consumption$Date >= as.Date( '2007-02-01' )
               & consumption$Date <= as.Date( '2007-02-02' ), ] 
png( filename='plot1.png', width=504, height=504, bg='transparent' )
hist( filtered$Global_active_power,
      xlab='Global Active Power (kilowatts)',
      main='Global Active Power', col='Red' )
dev.off()
