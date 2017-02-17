foreach ($i in $(1...4)){
    set-disk -Number $i -IsOffline $false
}

foreach ($i in $(1...4)){
    set-disk -Number $i -IsReadonly $false
}