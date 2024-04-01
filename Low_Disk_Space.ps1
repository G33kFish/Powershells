# Low Disk Storage script 
# Determines the amount of free space on the C drive
# If the percentage is below 10%
# Commands will be run until
# The percentage is at or above 10%
# or the script ends

cls
echo "======================="
echo "Low Disk Storage Script"
echo "======================="
echo " "
echo "Current Status:"
echo " "

# Get the drive information
$drive = Get-PSDrive C

# Calculate the percentage of free space
$percent
$percentFree = [math]::Round(($drive.Free / ($drive.Used+$drive.Free)) * 100)

# Output the percentage of free space
Write-Output "The C: drive has $percentFree% free space."
echo " "
pause

IF ($percentfree -lt 10) {

	# Empties the contents of the Recycle Bin 
	cls
	echo "Clearing Recycle Bin..."
	Clear-RecycleBin -force -ea 0
    cls
	echo "Task Complete."
	echo " "
	Write-Output "The C: drive has $percentFree% free space."
    echo " "
	pause
}

IF ($percentfree -lt 10) {

	# Removes Temporary System Files
	cls
	echo "Clearing System temp files..."
	dir $env:Temp | Remove-Item -recurse -force -ea 0
    cls
	echo "Task Complete."
	echo " "
	Write-Output "The C: drive has $percentFree% free space."
	pause
}

IF ($percentfree -lt 10) {

	# Removes Temporary User Files
	cls
	echo "Clearing User temp files..."
	dir c:\users*\AppData\Local\Temp | %{dir$_ | Remove-Item -recurse -force -ea 0}
    cls
	echo "Task Complete."
	echo " "
	Write-Output "The C: drive has $percentFree% free space."
	pause
}

IF ($percentfree -lt 10) {

	# Removes all log files older than 1 month  
	cls
	echo "Clearing Log files..."
	dir C:\Windows -recurse -force -file -ea 0 -include *.log | ?{$_.LastWriteTime -lt (Get-Date).AddMonths(-1)} | Remove-Item -force -ea 0
    cls
	echo "Task Complete."
	echo " "
	Write-Output "The C: drive has $percentFree% free space."
	pause
}

IF ($percentfree -lt 10) {

	# Removes Memory Dump files
	cls
	echo "Clearing Memory Dump files..."
	dir C:\Windows -recurse -force -file -ea 0 -include mem*.dmp | Remove-Item -force -ea 0
    cls
	echo "Task Complete."
	echo " "
	pause
}

cls
echo "All scripted tasks complete or not needed."
echo " "
Write-Output "The C: drive has $percentFree% free space."
echo " "

IF ($percentfree -lt 10) {
    echo "If the percentage is still greater than 10%, consider removing unused applications."
}
exit