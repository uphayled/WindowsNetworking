cls
# PowerShell script to list processes and group by company
get-Process | sort company | format-Table ProcessName -groupby company